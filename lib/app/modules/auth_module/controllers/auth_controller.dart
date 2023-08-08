import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:smarter/app/data/provider/box.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/auth_query.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/init_messaging.dart';
import 'package:yaml/yaml.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final _user = Rx<Map<String, dynamic>?>(null);

  Map<String, dynamic>? get user => _user.value;

  set user(value) => _user.value = value;

  String? fcmToken;

  RxString version = "".obs;

  RxBool isAutoLogin = RxBool(false);

  late Mixpanel mixpanel;

  Future<void> getMe() async {
    final result = await Client()
        .client
        .value
        .query(QueryOptions(document: gql(AuthQuery.me)));
    user = result.data!['me'];
  }

  get needMoreUserInfo => user == null
      ? false
      : user!['gym']['email'].isEmpty ||
          user!['gym']['businessRegistrationCertificate'].isEmpty ||
          user!['gym']['businessRegistrationNumber'].isEmpty ||
          user!['gym']['businessRegistrationNumber'].isEmpty ||
          user!['gym']['refundBankName'] == null ||
          user!['gym']['refundBankAccountNo'] == null ||
          user!['gym']['refundBankOwnerName'] == null ||
          user!['gym']['classPaymentBankName'] == null ||
          user!['gym']['classPaymentBankAccountNo'] == null ||
          user!['gym']['classPaymentBankOwnerName'] == null;

  @override
  void onInit() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    getAppVersion();
    super.onInit();
  }

  GraphQLClient authClient = GraphQLClient(
    link: HttpLink(
      '${dotenv.env['BASE_URL']}/graphql',
    ),
    defaultPolicies:
        DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  void logout() async {
    await Client().client.value.mutate(MutationOptions(
        document: gql(AuthMutation.removeFcmToken),
        variables: {'fcmToken': fcmToken}));
    Box().reset();
    Get.offAllNamed(Routes.auth);
  }

  void withdraw() async {
    await Client()
        .client
        .value
        .mutate(MutationOptions(document: gql(AuthMutation.withdraw)));
    Box().reset();
    Get.offAllNamed(Routes.auth);
  }

  // 인증용 토큰 (JWT)
  final RxString _token = ''.obs;

  String get token => _token.value;

  set token(value) => _token.value = value;
  Timer? timer;

  // 전화번호
  final Rx<String?> _phoneNumber = Rx<String?>(null);

  String? get phoneNumber => _phoneNumber.value;

  set phoneNumber(value) => _phoneNumber.value = value;

  // 로컬 DB에 토큰 저장
  void storeTokens(Map<String, dynamic> data) {
    Box().setToken(data['token']);
    if (data.containsKey('refreshToken')) {
      Box().setRefreshToken(data['refreshToken']);
    }
    Box().setRefreshExpiresIn(data['refreshExpiresIn']);
  }

  Future<void> login() async {
    if (!(idController.text.isNotEmpty && passwordController.text.isNotEmpty)) {
      showSnackBar('아이디와 비밀번호를 입력해주세요.');
      return;
    }
    final result = await authClient.mutate(
      MutationOptions(
        document: gql(AuthMutation.tokenAuth),
        variables: {
          'identification': idController.text,
          'password': passwordController.text,
          'fcmToken': fcmToken
        },
      ),
    );
    if (!result.hasException) {
      final isActive = result.data!['tokenAuth']['isActive'];
      if (isActive) {
        storeTokens(result.data!['tokenAuth']);
        user = result.data!['tokenAuth']['user'];
        await initMessaging();
        Get.offAllNamed(Routes.shop);
        idController.clear();
        passwordController.clear();
        mixpanel.track('로그인', properties: {'아이디': idController.text});
      }
    } else {
      Get.snackbar('로그인 실패', '아이디 또는 비밀번호를 확인해주세요.',
          backgroundColor: errorColor, colorText: backgroundColor);
    }
  }

  // 토큰 가져오기
  Future<String> getToken() async {
    if (user != null) {
      mixpanel.identify(user!['id']);
      mixpanel.getPeople().set('name', user!['name']);
      mixpanel.getPeople().set('phone', user!['phone']);
      mixpanel.getPeople().set('gym_id', user!['name']);
      mixpanel.getPeople().set('gym_name', user!['gym']['name']);
      if (user!['gym']['agency'] != null) {
        mixpanel.getPeople().set('agency_id', user!['gym']['agency']['id']);
        mixpanel.getPeople().set('agency_name', user!['gym']['agnecy']['name']);
      }
      mixpanel.getPeople().set('address', user!['gym']['address']);
      mixpanel.getPeople().set('detail_address', user!['gym']['detailAddress']);
      mixpanel.getPeople().set('zipcode', user!['gym']['zipCode']);
      mixpanel.getPeople().set('business_registration_number',
          user!['gym']['businessRegistrationNumber']);
      mixpanel.getPeople().set('app', 'flutter_master');
    }

    // 저장된 토큰이 없을 시 종료
    final token = await verifyToken();
    if (token != '') {
      return token;
    }

    if (Box().refreshToken != null) {
      // refreshToken 이 있다면 token 다시 생성
      final refreshTokenResult = await authClient.mutate(
        MutationOptions(
          document: gql(AuthMutation.refreshToken),
          variables: {
            'refreshToken': Box().refreshToken,
          },
        ),
      );

      if (refreshTokenResult.data != null) {
        storeTokens(refreshTokenResult.data!['refreshToken']);
        final token = await verifyToken();
        if (token != '') {
          return token;
        }
      }
    }

    if (token == '') {
      if (Get.routing.current != Routes.auth) {
        Get.offAllNamed(Routes.auth);
      }
    }

    return token;
  }

  Future<String> verifyToken() async {
    if (Box().token == null) {
      return '';
    }
    final result = await authClient.mutate(
      MutationOptions(
        document: gql(AuthMutation.verifyToken),
        variables: {
          'token': Box().token,
          'fcmToken': fcmToken,
        },
      ),
    );
    if (!result.hasException) {
      // 미승인 시 종료
      if (!result.data!['verifyToken']['isActive']) {
        return '';
      }

      // 성공
      user = result.data!['verifyToken']['user'];
      return Box().token!;
    }

    if (Box().refreshToken == null) {
      return '';
    }
    return '';
  }

  void getAppVersion() {
    rootBundle.loadString("pubspec.yaml").then((value) {
      var yaml = loadYaml(value);
      version.value = yaml['version'];
    });
  }
}

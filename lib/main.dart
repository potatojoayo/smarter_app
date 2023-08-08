import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart';

import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/get_initial_route.dart';
import 'package:smarter/app/global/utils/ko_message.dart';
import 'package:smarter/app/global/utils/no_android_glowing_overscroll_behavior.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/firebase_options.dart';
import 'package:smarter/initial_binding.dart';
import 'package:smarter/main_wrapper_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));

  KakaoSdk.init(nativeAppKey: '7163427ea711008be7e1ae7d3348bfc6');

  timeago.setLocaleMessages('ko', KoMessage());

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// GraphQL 사용을 위한 Hive store
  await initHiveForFlutter();

  /// .env 로딩
  await dotenv.load(fileName: '.env');
  String initialRoute = Routes.shop;
  Map<String, dynamic>? user;
  (initialRoute, user) = await getInitialRoute();
  Get.put(AuthController(), permanent: true);
  AuthController.to.mixpanel = await Mixpanel.init(
      "9e4c51e4e73c2498c8e34dd278a6ec8c",
      trackAutomaticEvents: true);
  AuthController.to.user = user;

  final url = Uri.parse(
      'https://smarter-config.s3.ap-northeast-2.amazonaws.com/config.json');
  final response = await http.get(url);
  final body = utf8.decode(response.bodyBytes);
  final baseUrl = jsonDecode(body)['baseUrl'];
  Client.init(baseUrl);

  runApp(App(
    initialRoute: initialRoute,
  ));
}

class App extends StatelessWidget {
  const App({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //세로 고정
    return GraphQLProvider(
      client: Client().client,
      child: GetMaterialApp(
        theme: appTheme,
        initialRoute: initialRoute,
        initialBinding: InitialBinding(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', ''), // English, no country code
        ],
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NoAndroidGlowingOverscrollBehavior(),
            child: Container(
              color: Colors.grey.shade50,
              child: SafeArea(
                child: MainWrapperWidget(child: child!),
              ),
            ),
          );
        },
        getPages: Routes.getPages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

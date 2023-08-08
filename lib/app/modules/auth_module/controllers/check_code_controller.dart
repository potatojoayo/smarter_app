import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CheckCodeController extends GetxController {
  static CheckCodeController get to => Get.find();

  final loadingController = RoundedLoadingButtonController();

  final authCodeController = TextEditingController();

  GraphQLClient authClient = GraphQLClient(
    link: HttpLink(
      // 'http://localhost:8000/graphql',
      '${dotenv.env['BASE_URL']}/graphql',
    ),
    defaultPolicies:
        DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
}

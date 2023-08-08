import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';

class Client {
  final HttpLink _httpLink;
  final AuthLink _authLink;
  late final Link _link;
  late final ValueNotifier<GraphQLClient> client;

  static late Client _graphqlProvider;

  Client.init(String baseUrl)
      : _httpLink = HttpLink('$baseUrl/graphql'),
        _authLink = AuthLink(getToken: () async {
          final token = await AuthController.to.getToken();
          return 'JWT $token';
        }) {
    _link = _authLink.concat(_httpLink);
    client = ValueNotifier(GraphQLClient(
      link: _link,
      defaultPolicies:
          DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ));
    _graphqlProvider = this;
  }

  factory Client() {
    return _graphqlProvider;
  }
}

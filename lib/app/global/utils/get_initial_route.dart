import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/box.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/routes/routes.dart';

void storeTokens(Map<String, dynamic> data) {
  Box().setToken(data['token']);
  if (data.containsKey('refreshToken')) {
    Box().setRefreshToken(data['refreshToken']);
  }
  Box().setRefreshExpiresIn(data['refreshExpiresIn']);
}

Future<(String, Map<String, dynamic>?)> getInitialRoute() async {
  GraphQLClient authClient = GraphQLClient(
    link: HttpLink('${dotenv.env['BASE_URL']}/graphql'),
    defaultPolicies:
        DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  if (Box().token != null) {
    final result = await authClient.mutate(
      MutationOptions(
        document: gql(AuthMutation.verifyToken),
        variables: {
          'token': Box().token,
        },
      ),
    );
    if (!result.hasException) {
      final user = result.data!['verifyToken']['user'] as Map<String, dynamic>;
      return (Routes.shop, user);
    } else {
      // 토큰 refresh
      // refreshToken 없을 경우
      if (Box().refreshToken == null) {
        return (Routes.auth, null);
      }
      // refreshToken 이 있다면 token 다시 생성
      try {
        final result = await authClient.mutate(
          MutationOptions(
            document: gql(AuthMutation.refreshToken),
            variables: {
              'refreshToken': Box().refreshToken,
            },
          ),
        );
        storeTokens(result.data!['refreshToken']);
        final verifyResult = await authClient.mutate(
          MutationOptions(
            document: gql(AuthMutation.verifyToken),
            variables: {
              'token': Box().token,
            },
          ),
        );
        final user =
            verifyResult.data!['verifyToken']['user'] as Map<String, dynamic>;
        return (Routes.shop, user);
      } catch (e) {
        // token과 refreshToken 모두 만료된 경우
        return (Routes.auth, null);
      }
    }
  }
  return (Routes.auth, null);
}

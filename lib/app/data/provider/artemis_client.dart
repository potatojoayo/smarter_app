import 'package:artemis/artemis.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';

class Artemis {
  late final ArtemisClient client;

  late final Link _link;
  static final Artemis _artemisClient = Artemis._();
  final HttpLink _httpLink;
  final AuthLink _authLink;

  Artemis._()
      : _httpLink = HttpLink('${dotenv.env['BASE_URL']}/graphql'),
        _authLink = AuthLink(getToken: () async {
          final token = await AuthController.to.getToken();
          return 'JWT $token';
        }) {
    _link = _authLink.concat(_httpLink);
    client = ArtemisClient.fromLink(_link);
  }

  factory Artemis() {
    return _artemisClient;
  }
}

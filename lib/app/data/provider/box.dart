import 'package:graphql_flutter/graphql_flutter.dart';

class Box {
  final _store = HiveStore();
  static const _token = 'token';
  static const _refreshToken = 'refreshToken';
  static const _refreshExpiresIn = 'refreshExpiresIn';

  String? get token => _store.get(_token)?[_token];
  void setToken(t) {
    _store.put(_token, {_token: t});
  }

  String? get refreshToken => _store.get(_refreshToken)?[_refreshToken];
  void setRefreshToken(r) {
    _store.put(_refreshToken, {_refreshToken: r});
  }

  DateTime? get refreshExpiresIn {
    final int? timestamp = _store.get(_refreshExpiresIn)?[_refreshExpiresIn];
    if (timestamp == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(
        _store.get(_refreshExpiresIn)?[_refreshExpiresIn] * 1000);
  }

  void setRefreshExpiresIn(e) {
    _store.put(_refreshExpiresIn, {_refreshExpiresIn: e});
  }

  void reset() {
    _store.reset();
  }

  static final Box _instance = Box._();

  Box._();

  factory Box() {
    return _instance;
  }
}

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientConfig {
  static const String _baseUrl = 'https://spacex-production.up.railway.app/graphql';
  static GraphQLClient? _client;

  static Future<void> init() async {
    if (_client == null) {
      final HttpLink httpLink = HttpLink(_baseUrl);
      _client = GraphQLClient(
        link: httpLink,
        queryRequestTimeout: const Duration(seconds: 60),
        cache: GraphQLCache(),
      );
    }
  }

  static GraphQLClient get client {
    if (_client == null) {
      throw StateError('GraphQLClient not initialized. Call init() first.');
    }
    return _client!;
  }
}

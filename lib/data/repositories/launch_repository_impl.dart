import 'package:graphql_flutter/graphql_flutter.dart';
import '../datasources/launch_queries.dart';
import '../mappers/launch_mapper.dart';
import '../models/launch_model.dart';
import '../models/launch_filter_model.dart';
import '../models/rocket_model.dart';
import '../../domain/repositories/launch_repository.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final GraphQLClient _client;

  LaunchRepositoryImpl(this._client);

  @override
  Future<List<LaunchModel>> getLaunches({
    int? limit,
    int? offset,
    String? order,
    String? sort,
    LaunchFilter? filter,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(LaunchQueries.getLaunches),
        variables: LaunchMapper.toGraphQLVariables(
          limit: limit,
          offset: offset,
          order: order,
          sort: sort,
          filter: filter,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    if (result.data == null || !result.data!.containsKey('launchesPast')) {
      return [];
    }

    return LaunchMapper.fromGraphQLResponse(result.data!);
  }

  @override
  Future<LaunchModel?> getLaunchById(String id) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(LaunchQueries.getLaunchById),
        variables: LaunchMapper.toGraphQLSingleLaunchVariables(id),
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return LaunchMapper.fromGraphQLSingleResponse(result.data!);
  }

  @override
  Future<List<RocketModel>> getRockets() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(LaunchQueries.getRockets),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    if (result.data == null || !result.data!.containsKey('rockets')) {
      return [];
    }

    final List<dynamic> rockets = result.data!['rockets'] as List<dynamic>;
    return rockets.map((rocket) => RocketModel.fromJson(rocket)).toList();
  }
}

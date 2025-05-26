import 'package:graphql_flutter/graphql_flutter.dart';
import '../datasources/launch_queries.dart';
import '../mappers/launch_mapper.dart';
import '../models/launch_model.dart';
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
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(LaunchQueries.getLaunches),
        variables: LaunchMapper.toGraphQLVariables(
          limit: limit,
          offset: offset,
          order: order,
          sort: sort,
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
}

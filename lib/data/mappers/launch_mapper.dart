import '../models/launch_model.dart';
import '../models/launch_filter_model.dart';
import '../models/request_launch_model.dart';

class LaunchMapper {
  static List<LaunchModel> fromGraphQLResponse(Map<String, dynamic> response) {
    final List<dynamic> launches = response['launchesPast'] as List<dynamic>;
    return launches.map((launch) => LaunchModel.fromJson(launch)).toList();
  }

  static LaunchModel? fromGraphQLSingleResponse(Map<String, dynamic> response) {
    final launch = response['launch'];
    if (launch == null) return null;
    return LaunchModel.fromJson(launch);
  }

  static Map<String, dynamic> toGraphQLVariables({
    int? limit,
    int? offset,
    String? order,
    String? sort,
    LaunchFilter? filter,
  }) {
    final requestModel = filter?.toRequestLaunchModel(
          limit: limit,
          offset: offset,
          order: order,
          sort: sort,
        ) ??
        RequestLaunchModel(
          limit: limit,
          offset: offset,
          order: order,
          sort: sort,
        );

    return requestModel.toJson();
  }

  static Map<String, dynamic> toGraphQLSingleLaunchVariables(String id) {
    return {
      'id': id,
    };
  }
}

import '../models/launch_model.dart';

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
  }) {
    return {
      'limit': limit,
      if (offset != null) 'offset': offset,
      if (order != null) 'order': order,
      if (sort != null) 'sort': sort,
    };
  }

  static Map<String, dynamic> toGraphQLSingleLaunchVariables(String id) {
    return {
      'id': id,
    };
  }
}

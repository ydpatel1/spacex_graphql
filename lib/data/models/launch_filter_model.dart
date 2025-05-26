import 'request_launch_model.dart';

class LaunchFilter {
  final String? searchQuery;
  final int? year;
  final bool? success;
  final String? rocketName;

  const LaunchFilter({
    this.searchQuery,
    this.year,
    this.success,
    this.rocketName,
  });

  LaunchFilter copyWith({
    String? searchQuery,
    int? year,
    bool? success,
    String? rocketName,
  }) {
    return LaunchFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      year: year ?? this.year,
      success: success ?? this.success,
      rocketName: rocketName ?? this.rocketName,
    );
  }

  LaunchFindModel toLaunchFindModel() {
    return LaunchFindModel(
      missionName: searchQuery,
      launchYear: year?.toString(),
      launchSuccess: success,
      rocketName: rocketName,
    );
  }

  RequestLaunchModel toRequestLaunchModel({
    int? limit,
    int? offset,
    String? order,
    String? sort,
  }) {
    return RequestLaunchModel(
      find: toLaunchFindModel(),
      limit: limit,
      offset: offset,
      order: order,
      sort: sort,
    );
  }
}

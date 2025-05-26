import 'package:equatable/equatable.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';

class LaunchAnalyticsModel extends Equatable {
  final Map<int, int> launchesByYear;
  final Map<int, double> successRateByYear;
  final Map<String, int> launchesByRocket;
  final Map<String, double> successRateByRocket;
  final Map<String, int> launchesByLaunchSite;
  final Map<String, double> successRateByLaunchSite;
  final int totalLaunches;
  final int successfulLaunches;
  final double overallSuccessRate;

  const LaunchAnalyticsModel({
    required this.launchesByYear,
    required this.successRateByYear,
    required this.launchesByRocket,
    required this.successRateByRocket,
    required this.launchesByLaunchSite,
    required this.successRateByLaunchSite,
    required this.totalLaunches,
    required this.successfulLaunches,
    required this.overallSuccessRate,
  });

  factory LaunchAnalyticsModel.fromLaunches(List<LaunchModel> launches) {
    final launchesByYear = <int, int>{};
    final successfulLaunchesByYear = <int, int>{};
    final launchesByRocket = <String, int>{};
    final successfulLaunchesByRocket = <String, int>{};
    final launchesByLaunchSite = <String, int>{};
    final successfulLaunchesByLaunchSite = <String, int>{};
    var totalLaunches = 0;
    var successfulLaunches = 0;

    for (final launch in launches) {
      final year = int.parse(launch.launchYear);
      final rocketName = launch.rocket.rocketName;
      final launchSite = launch.launchSite?.siteName ?? 'Unknown';
      final isSuccess = launch.launchSuccess == true;

      // Update year statistics
      launchesByYear[year] = (launchesByYear[year] ?? 0) + 1;
      if (isSuccess) {
        successfulLaunchesByYear[year] = (successfulLaunchesByYear[year] ?? 0) + 1;
      }

      // Update rocket statistics
      launchesByRocket[rocketName] = (launchesByRocket[rocketName] ?? 0) + 1;
      if (isSuccess) {
        successfulLaunchesByRocket[rocketName] = (successfulLaunchesByRocket[rocketName] ?? 0) + 1;
      }

      // Update launch site statistics
      launchesByLaunchSite[launchSite] = (launchesByLaunchSite[launchSite] ?? 0) + 1;
      if (isSuccess) {
        successfulLaunchesByLaunchSite[launchSite] =
            (successfulLaunchesByLaunchSite[launchSite] ?? 0) + 1;
      }

      totalLaunches++;
      if (isSuccess) {
        successfulLaunches++;
      }
    }

    // Calculate success rates
    final successRateByYear = <int, double>{};
    for (final year in launchesByYear.keys) {
      successRateByYear[year] = (successfulLaunchesByYear[year] ?? 0) / launchesByYear[year]! * 100;
    }

    final successRateByRocket = <String, double>{};
    for (final rocket in launchesByRocket.keys) {
      successRateByRocket[rocket] =
          (successfulLaunchesByRocket[rocket] ?? 0) / launchesByRocket[rocket]! * 100;
    }

    final successRateByLaunchSite = <String, double>{};
    for (final site in launchesByLaunchSite.keys) {
      successRateByLaunchSite[site] =
          (successfulLaunchesByLaunchSite[site] ?? 0) / launchesByLaunchSite[site]! * 100;
    }

    return LaunchAnalyticsModel(
      launchesByYear: launchesByYear,
      successRateByYear: successRateByYear,
      launchesByRocket: launchesByRocket,
      successRateByRocket: successRateByRocket,
      launchesByLaunchSite: launchesByLaunchSite,
      successRateByLaunchSite: successRateByLaunchSite,
      totalLaunches: totalLaunches,
      successfulLaunches: successfulLaunches,
      overallSuccessRate: totalLaunches > 0 ? (successfulLaunches / totalLaunches * 100) : 0,
    );
  }

  @override
  List<Object?> get props => [
        launchesByYear,
        successRateByYear,
        launchesByRocket,
        successRateByRocket,
        launchesByLaunchSite,
        successRateByLaunchSite,
        totalLaunches,
        successfulLaunches,
        overallSuccessRate,
      ];
}

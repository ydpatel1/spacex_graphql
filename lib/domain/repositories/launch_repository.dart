import '../../data/models/launch_model.dart';
import '../../data/models/launch_filter_model.dart';
import '../../data/models/rocket_model.dart';

abstract class LaunchRepository {
  Future<List<LaunchModel>> getLaunches({
    int? limit,
    int? offset,
    String? order,
    String? sort,
    LaunchFilter? filter,
  });

  Future<LaunchModel?> getLaunchById(String id);

  Future<List<RocketModel>> getRockets();
}

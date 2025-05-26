import '../../data/models/launch_model.dart';

abstract class LaunchRepository {
  Future<List<LaunchModel>> getLaunches({
    int? limit,
    int? offset,
    String? order,
    String? sort,
  });

  Future<LaunchModel?> getLaunchById(String id);
}

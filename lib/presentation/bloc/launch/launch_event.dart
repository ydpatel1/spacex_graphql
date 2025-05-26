import 'package:equatable/equatable.dart';
import '../../../data/models/launch_model.dart';

abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

class FetchLaunches extends LaunchEvent {
  final int? limit;
  final int? offset;
  final String? order;
  final String? sort;

  const FetchLaunches({
    this.limit,
    this.offset,
    this.order,
    this.sort,
  });

  @override
  List<Object?> get props => [limit, offset, order, sort];
}

class FetchLaunchById extends LaunchEvent {
  final String id;

  const FetchLaunchById(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshLaunches extends LaunchEvent {
  final int limit;
  final int offset;

  RefreshLaunches({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];
}

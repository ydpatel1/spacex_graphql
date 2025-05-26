import 'package:equatable/equatable.dart';
import 'package:spacex_graphql/data/models/launch_filter_model.dart';

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
  final LaunchFilter? filter;

  const FetchLaunches({
    this.limit,
    this.offset,
    this.order,
    this.sort,
    this.filter,
  });

  @override
  List<Object?> get props => [limit, offset, order, sort, filter];
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
  final LaunchFilter? filter;

  const RefreshLaunches({
    required this.limit,
    required this.offset,
    this.filter,
  });

  @override
  List<Object?> get props => [limit, offset, filter];
}

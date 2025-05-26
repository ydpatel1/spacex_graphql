import 'package:equatable/equatable.dart';

abstract class LaunchDetailsEvent extends Equatable {
  const LaunchDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchLaunchDetails extends LaunchDetailsEvent {
  final String id;

  const FetchLaunchDetails(this.id);

  @override
  List<Object> get props => [id];
}

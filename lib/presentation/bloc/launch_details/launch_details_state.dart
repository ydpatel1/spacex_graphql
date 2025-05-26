import 'package:equatable/equatable.dart';
import '../../../data/models/launch_model.dart';

abstract class LaunchDetailsState extends Equatable {
  const LaunchDetailsState();

  @override
  List<Object?> get props => [];
}

class LaunchDetailsInitial extends LaunchDetailsState {}

class LaunchDetailsLoading extends LaunchDetailsState {}

class LaunchDetailsLoaded extends LaunchDetailsState {
  final LaunchModel launch;

  const LaunchDetailsLoaded(this.launch);

  @override
  List<Object> get props => [launch];
}

class LaunchDetailsError extends LaunchDetailsState {
  final String message;

  const LaunchDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

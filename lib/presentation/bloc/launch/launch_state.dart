import 'package:equatable/equatable.dart';
import '../../../data/models/launch_model.dart';

abstract class LaunchState extends Equatable {
  const LaunchState();

  @override
  List<Object?> get props => [];
}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchLoaded extends LaunchState {
  final List<LaunchModel> launches;

  const LaunchLoaded(this.launches);

  @override
  List<Object> get props => [launches];
}

class LaunchDetailLoaded extends LaunchState {
  final LaunchModel launch;

  const LaunchDetailLoaded(this.launch);

  @override
  List<Object> get props => [launch];
}

class LaunchError extends LaunchState {
  final String message;

  const LaunchError(this.message);

  @override
  List<Object> get props => [message];
}

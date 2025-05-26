import 'package:equatable/equatable.dart';
import '../../../data/models/launch_model.dart';

abstract class LaunchState extends Equatable {
  final List<LaunchModel>? launches;
  const LaunchState({this.launches});

  @override
  List<Object?> get props => [launches];
}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchLoaded extends LaunchState {
  const LaunchLoaded({super.launches});

  @override
  List<Object?> get props => [launches];
}

class LaunchLoadedWithLoading extends LaunchState {
  const LaunchLoadedWithLoading({super.launches});

  @override
  List<Object?> get props => [launches];  
}

class LaunchRefreshingLoding extends LaunchState {
  const LaunchRefreshingLoding({super.launches});

  @override
  List<Object?> get props => [launches];
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

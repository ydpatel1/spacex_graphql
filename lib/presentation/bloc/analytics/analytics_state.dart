import 'package:equatable/equatable.dart';
import 'package:spacex_graphql/data/models/launch_analytics_model.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final LaunchAnalyticsModel analytics;

  const AnalyticsLoaded(this.analytics);

  @override
  List<Object?> get props => [analytics];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError(this.message);

  @override
  List<Object?> get props => [message];
}

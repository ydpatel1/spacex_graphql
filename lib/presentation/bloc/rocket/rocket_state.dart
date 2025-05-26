import 'package:equatable/equatable.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';

abstract class RocketState extends Equatable {
  const RocketState();

  @override
  List<Object?> get props => [];
}

class RocketInitial extends RocketState {}

class RocketLoading extends RocketState {}

class RocketLoaded extends RocketState {
  final List<RocketModel> rockets;
  final RocketModel? selectedRocket;
  final RocketModel? comparisonRocket;

  const RocketLoaded({
    required this.rockets,
    this.selectedRocket,
    this.comparisonRocket,
  });

  RocketLoaded copyWith({
    List<RocketModel>? rockets,
    RocketModel? selectedRocket,
    RocketModel? comparisonRocket,
  }) {
    return RocketLoaded(
      rockets: rockets ?? this.rockets,
      selectedRocket: selectedRocket ?? this.selectedRocket,
      comparisonRocket: comparisonRocket ?? this.comparisonRocket,
    );
  }

  @override
  List<Object?> get props => [rockets, selectedRocket, comparisonRocket];
}

class RocketError extends RocketState {
  final String message;

  const RocketError(this.message);

  @override
  List<Object> get props => [message];
}

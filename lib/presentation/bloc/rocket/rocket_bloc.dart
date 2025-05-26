import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';
import 'package:spacex_graphql/domain/repositories/launch_repository.dart';
import 'rocket_state.dart';

class RocketBloc extends Cubit<RocketState> {
  final LaunchRepository _launchRepository;

  RocketBloc(this._launchRepository) : super(RocketInitial());

  Future<void> loadRockets() async {
    try {
      emit(RocketLoading());
      final rockets = await _launchRepository.getRockets();
      emit(RocketLoaded(rockets: rockets));
    } catch (e) {
      emit(RocketError(e.toString()));
    }
  }

  void selectRocket(RocketModel rocket) {
    if (state is RocketLoaded) {
      final currentState = state as RocketLoaded;
      emit(currentState.copyWith(selectedRocket: rocket));
    }
  }

  void selectComparisonRocket(RocketModel rocket) {
    if (state is RocketLoaded) {
      final currentState = state as RocketLoaded;
      emit(currentState.copyWith(comparisonRocket: rocket));
    }
  }

  void clearSelectedRocket() {
    if (state is RocketLoaded) {
      final currentState = state as RocketLoaded;
      emit(currentState.copyWith(selectedRocket: null));
    }
  }

  void clearComparisonRocket() {
    if (state is RocketLoaded) {
      final currentState = state as RocketLoaded;
      emit(currentState.copyWith(comparisonRocket: null));
    }
  }
}

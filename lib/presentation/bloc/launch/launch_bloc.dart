import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/launch_repository.dart';
import 'launch_event.dart';
import 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  final LaunchRepository _launchRepository;

  LaunchBloc(this._launchRepository) : super(LaunchInitial()) {
    on<FetchLaunches>(_onFetchLaunches);
    on<FetchLaunchById>(_onFetchLaunchById);
    on<RefreshLaunches>(_onRefreshLaunches);
  }

  Future<void> _onFetchLaunches(
    FetchLaunches event,
    Emitter<LaunchState> emit,
  ) async {
    try {
      if (state is LaunchInitial) {
        emit(LaunchLoading());
      } else {
        emit(LaunchLoadedWithLoading(launches: state.launches));
      }

      final launches = await _launchRepository.getLaunches(
        limit: event.limit,
        offset: event.offset,
        order: event.order,
        sort: event.sort,
      );

      if (state is LaunchLoadedWithLoading) {
        final currentState = state as LaunchLoadedWithLoading;
          emit(LaunchLoaded(
          launches: [...(currentState.launches ?? []), ...launches],
        ));
      } else {
        emit(LaunchLoaded(launches: launches));
      }
    } catch (e) {
      emit(LaunchError(e.toString()));
    }
  }

  Future<void> _onFetchLaunchById(
    FetchLaunchById event,
    Emitter<LaunchState> emit,
  ) async {
    try {
      emit(LaunchLoading());
      final launch = await _launchRepository.getLaunchById(event.id);
      if (launch != null) {
        emit(LaunchDetailLoaded(launch));
      } else {
        emit(const LaunchError('Launch not found'));
      }
    } catch (e) {
      emit(LaunchError(e.toString()));
    }
  }

  Future<void> _onRefreshLaunches(
    RefreshLaunches event,
    Emitter<LaunchState> emit,
  ) async {
    emit(LaunchRefreshingLoding(launches: state.launches));
    try {
      final launches = await _launchRepository.getLaunches(
        limit: event.limit,
        offset: event.offset,
      );
      emit(LaunchLoaded(launches: launches));
    } catch (e) {
      emit(LaunchError(e.toString()));
    }
  }
}

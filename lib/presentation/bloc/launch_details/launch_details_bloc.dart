import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/launch_repository.dart';
import 'launch_details_event.dart';
import 'launch_details_state.dart';

class LaunchDetailsBloc extends Bloc<LaunchDetailsEvent, LaunchDetailsState> {
  final LaunchRepository repository;

  LaunchDetailsBloc(this.repository) : super(LaunchDetailsInitial()) {
    on<FetchLaunchDetails>(_onFetchLaunchDetails);
  }

  Future<void> _onFetchLaunchDetails(
    FetchLaunchDetails event,
    Emitter<LaunchDetailsState> emit,
  ) async {
    try {
      emit(LaunchDetailsLoading());
      final launch = await repository.getLaunchById(event.id);
      if (launch != null) {
        emit(LaunchDetailsLoaded(launch));
      } else {
        emit(const LaunchDetailsError('Launch not found'));
      }
    } catch (e) {
      emit(LaunchDetailsError(e.toString()));
    }
  }
}

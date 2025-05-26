import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/domain/repositories/launch_repository.dart';
import 'package:spacex_graphql/data/models/launch_analytics_model.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final LaunchRepository repository;

  AnalyticsBloc(this.repository) : super(AnalyticsInitial()) {
    on<FetchAnalytics>(_onFetchAnalytics);
  }

  Future<void> _onFetchAnalytics(
    FetchAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    try {
      emit(AnalyticsLoading());

      final launches = await repository.getLaunches(
        limit: 1000, // Get all launches for analytics
        offset: 0,
        order: 'desc',
        sort: 'launch_date_utc',
      );

      final analytics = LaunchAnalyticsModel.fromLaunches(launches);
      emit(AnalyticsLoaded(analytics));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_event.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_state.dart';
import 'package:spacex_graphql/presentation/widgets/error_view.dart';
import 'package:spacex_graphql/presentation/widgets/launch_card.dart';
import 'package:spacex_graphql/presentation/widgets/loading_view.dart';

class LaunchListScreen extends StatefulWidget {
  const LaunchListScreen({super.key});

  @override
  State<LaunchListScreen> createState() => _LaunchListScreenState();
}

class _LaunchListScreenState extends State<LaunchListScreen> {
  final _scrollController = ScrollController();
  static const int _pageSize = 10;
  int _currentOffset = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    _currentOffset = 0;
    context.read<LaunchBloc>().add(
          FetchLaunches(
            limit: _pageSize,
            offset: _currentOffset,
          ),
        );
  }

  void _loadMoreData() {
    if (!_isLoadingMore) {
        _isLoadingMore = true;
      _currentOffset += _pageSize;

      context.read<LaunchBloc>().add(
            FetchLaunches(
              limit: _pageSize,
              offset: _currentOffset,
            ),
          );
    }
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingMore) {
      _loadMoreData();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  

  Future<void> _onRefresh() async {
    _currentOffset = 0;
    context.read<LaunchBloc>().add(
          RefreshLaunches(
            limit: _pageSize,
            offset: _currentOffset,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
      ),
      body: BlocConsumer<LaunchBloc, LaunchState>(
        listener: (context, state) {
          if (state is LaunchLoaded) {
            _isLoadingMore = false;
          }
        },
        builder: (context, state) {
          if (state is LaunchInitial || (state is LaunchLoading && _currentOffset == 0)) {
            return const LoadingView();
          }

          if (state is LaunchError) {
            return ErrorView(
              message: state.message,
              onRetry: _loadInitialData,
            );
          }
List<LaunchModel> launches = state.launches ?? [];
          
          if (launches.isEmpty && _currentOffset == 0) {
              return const Center(
                child: Text('No launches found'),
              );
            }
          print("State: ${state.runtimeType}");

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
              itemCount: launches.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                if (index >= launches.length && state is LaunchLoadedWithLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                }
                final launch = launches[index];
                if (state is LaunchRefreshingLoding && index == 0) {
                  print("state is LaunchRefreshingLoding $index");
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: LaunchCard(
                          launch: launch,
                          onTap: () {
                            // TODO: Navigate to launch details
                          },
                        ),
                      )
                    ],
                  );
                }
                  return LaunchCard(
                    launch: launch,
                    onTap: () {
                      // TODO: Navigate to launch details
                    },
                  );
                },
              ),
          );
        },
      ),
    );
  }
}

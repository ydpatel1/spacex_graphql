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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<LaunchBloc>().add(const FetchLaunches(limit: 10, offset: 0));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<LaunchBloc>().add(const FetchLaunches(limit: 10, offset: 0));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
      ),
      body: BlocBuilder<LaunchBloc, LaunchState>(
        builder: (context, state) {
          if (state is LaunchInitial || state is LaunchLoading) {
            return const LoadingView();
          }

          if (state is LaunchError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<LaunchBloc>().add(const FetchLaunches());
              },
            );
          }

          if (state is LaunchLoaded) {
            if (state.launches.isEmpty) {
              return const Center(
                child: Text('No launches found'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<LaunchBloc>().add(const FetchLaunches(limit: 10, offset: 0));
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.launches.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.launches.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final launch = state.launches[index];
                  return LaunchCard(
                    launch: launch,
                    onTap: () {
                      // TODO: Navigate to launch details
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

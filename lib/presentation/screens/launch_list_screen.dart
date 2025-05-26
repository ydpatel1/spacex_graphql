import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';
import 'package:spacex_graphql/data/models/launch_filter_model.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_event.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_state.dart';
import 'package:spacex_graphql/presentation/widgets/error_view.dart';
import 'package:spacex_graphql/presentation/widgets/launch_card.dart';
import 'package:spacex_graphql/presentation/widgets/loading_view.dart';
import 'package:spacex_graphql/presentation/screens/launch_details_screen.dart';

class LaunchListScreen extends StatefulWidget {
  const LaunchListScreen({super.key});

  @override
  State<LaunchListScreen> createState() => _LaunchListScreenState();
}

class _LaunchListScreenState extends State<LaunchListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  static const int _pageSize = 10;
  int _currentOffset = 0;
  bool _isLoadingMore = false;
  LaunchFilter _currentFilter = const LaunchFilter();
  bool _showFilters = false;
  List<RocketModel> _rockets = [];
  bool _isLoadingRockets = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
    _loadRockets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRockets() async {
    _isLoadingRockets = true;

    try {
      final rockets = await context.read<LaunchBloc>().repository.getRockets();
      _rockets = rockets;
      _isLoadingRockets = false;
    } catch (e) {
      _isLoadingRockets = false;
      // Handle error if needed
    }
  }

  void _loadInitialData() {
    _currentOffset = 0;
    context.read<LaunchBloc>().add(
          FetchLaunches(
            limit: _pageSize,
            offset: _currentOffset,
            filter: _currentFilter,
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
              filter: _currentFilter,
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
            filter: _currentFilter,
          ),
        );
  }

  void _applyFilters() {
    setState(() {
      _currentFilter = _currentFilter.copyWith(
        searchQuery: _searchController.text.isNotEmpty ? _searchController.text : null,
      );
      _currentOffset = 0;
      _loadInitialData();
    });
  }

  Widget _buildFilterSection() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _showFilters ? 200 : 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search launches...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _applyFilters,
                  ),
                ),
                onSubmitted: (_) => _applyFilters(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int?>(
                      decoration: const InputDecoration(
                        labelText: 'Year',
                      ),
                      value: _currentFilter.year,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All Years')),
                        ...List.generate(
                          14,
                          (index) => DropdownMenuItem(
                            value: 2010 + index,
                            child: Text('${2010 + index}'),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _currentFilter = _currentFilter.copyWith(year: value);
                          _currentOffset = 0;
                          _loadInitialData();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<bool?>(
                      decoration: const InputDecoration(
                        labelText: 'Status',
                      ),
                      value: _currentFilter.success,
                      items: const [
                        DropdownMenuItem(value: null, child: Text('All')),
                        DropdownMenuItem(value: true, child: Text('Successful')),
                        DropdownMenuItem(value: false, child: Text('Failed')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _currentFilter = _currentFilter.copyWith(success: value);
                          _currentOffset = 0;
                          _loadInitialData();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoadingRockets
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String?>(
                      decoration: const InputDecoration(
                        labelText: 'Rocket Type',
                      ),
                      value: _currentFilter.rocketName,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All Rockets')),
                        ..._rockets.map((rocket) => DropdownMenuItem(
                              value: rocket.name,
                              child: Text(rocket.name),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _currentFilter = _currentFilter.copyWith(rocketName: value);
                          _currentOffset = 0;
                          _loadInitialData();
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: BlocConsumer<LaunchBloc, LaunchState>(
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
                  return Column(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No launches found'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: _loadInitialData,
                          child: const Text('Retry'),
                        ),
                      ),
                    ],
                  );
                }

                List<LaunchModel> launches = state.launches ?? [];
                
                if (launches.isEmpty && _currentOffset == 0) {
                  return const Center(
                    child: Text('No launches found'),
                  );
                }

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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LaunchDetailsScreen(
                                        launchId: launch.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                      return LaunchCard(
                        launch: launch,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LaunchDetailsScreen(
                                launchId: launch.id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

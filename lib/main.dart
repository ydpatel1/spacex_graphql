import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/core/network/graphql_client.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/launch_repository_impl.dart';
import 'domain/repositories/launch_repository.dart';
import 'presentation/bloc/launch/launch_bloc.dart';
import 'presentation/screens/launch_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveConfig.init();
  await GraphQLClientConfig.init();
  runApp(const SpaceXApp());
}

class SpaceXApp extends StatelessWidget {
  const SpaceXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LaunchRepository>(
          create: (context) => LaunchRepositoryImpl(
            GraphQLClientConfig.client,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LaunchBloc>(
            create: (context) => LaunchBloc(
              context.read<LaunchRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'SpaceX Explorer',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const LaunchListScreen(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to SpaceX Explorer'),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.rocket_launch),
            label: 'Launches',
          ),
          NavigationDestination(
            icon: Icon(Icons.rocket),
            label: 'Rockets',
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        onDestinationSelected: (index) {
          // TODO: Implement navigation
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/core/network/graphql_client.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/launch_repository_impl.dart';
import 'domain/repositories/launch_repository.dart';
import 'presentation/bloc/launch/launch_bloc.dart';
import 'presentation/bloc/launch_details/launch_details_bloc.dart';
import 'presentation/screens/launch_list_screen.dart';
import 'presentation/screens/rocket_catalog_screen.dart';
import 'presentation/screens/rocket_comparison_screen.dart';

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
          BlocProvider<LaunchDetailsBloc>(
            create: (context) => LaunchDetailsBloc(
              context.read<LaunchRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'SpaceX Explorer',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Explorer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LaunchListScreen()),
                );
              },
              child: const Text('Launch History'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RocketCatalogScreen()),
                );
              },
              child: const Text('Rocket Catalog'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RocketComparisonScreen()),
                );
              },
              child: const Text('Compare Rockets'),
            ),
          ],
        ),
      ),
    );
  }
}

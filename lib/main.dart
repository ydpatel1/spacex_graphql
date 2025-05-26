import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/core/network/graphql_client.dart';
import 'package:spacex_graphql/core/theme/app_theme.dart';
import 'package:spacex_graphql/data/repositories/launch_repository_impl.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/launch_details/launch_details_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/rocket/rocket_bloc.dart';
import 'package:spacex_graphql/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GraphQLClientConfig.init();
  runApp(const SpaceXApp());
}

class SpaceXApp extends StatelessWidget {
  const SpaceXApp({super.key});

  @override
  Widget build(BuildContext context) {
    final graphQLClient = GraphQLClientConfig.client;
    final launchRepository = LaunchRepositoryImpl(graphQLClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LaunchBloc(launchRepository),
        ),
        BlocProvider(
          create: (context) => RocketBloc(launchRepository),
        ),
        BlocProvider(
          create: (context) => LaunchDetailsBloc(launchRepository),
        ),
      ],
      child: MaterialApp(
        title: 'SpaceX Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}

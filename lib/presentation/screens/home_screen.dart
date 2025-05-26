import 'package:flutter/material.dart';
import 'package:spacex_graphql/presentation/screens/launch_list_screen.dart';
import 'package:spacex_graphql/presentation/screens/rocket_catalog_screen.dart';
import 'package:spacex_graphql/presentation/screens/rocket_comparison_screen.dart';

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

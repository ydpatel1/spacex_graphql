import 'package:flutter/material.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'package:intl/intl.dart';

class LaunchCard extends StatelessWidget {
  final LaunchModel launch;
  final VoidCallback onTap;

  const LaunchCard({
    super.key,
    required this.launch,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                launch.missionName ?? 'Unknown Mission',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Launch Date: ${launch.launchDateLocal != null ? dateFormat.format(DateTime.parse(launch.launchDateLocal!)) : 'Unknown'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Rocket: ${launch.rocket?.rocketName ?? 'Unknown'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Launch Site: ${launch.launchSite?.siteName ?? 'Unknown'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Status: ${launch.launchSuccess == true ? 'Success' : 'Failed'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: launch.launchSuccess == true ? Colors.green : Colors.red,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

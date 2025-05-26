import 'package:flutter/material.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'package:intl/intl.dart';
import 'app_network_image.dart';
import 'countdown_timer.dart';

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
    final dateFormat = DateFormat('MMMM d, yyyy HH:mm');
    final launchDate = DateTime.parse(launch.launchDateLocal);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (launch.links.missionPatch != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: AppNetworkImage(
                        imageUrl: launch.links.missionPatch!,
                        width: 60,
                        height: 60,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                launch.missionName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            if (launch.upcoming)
                              CountdownTimer(
                                launchDate: launchDate,
                                isUpcoming: launch.upcoming,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Launch Date: ${launch.launchDateLocal.isNotEmpty ? dateFormat.format(launchDate) : 'Unknown'}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rocket: ${launch.rocket.rocketName}',
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
                ],
              ),
              if (launch.links.flickrImages.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: launch.links.flickrImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: AppNetworkImage(
                          imageUrl: launch.links.flickrImages[index],
                          width: 120,
                          height: 120,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

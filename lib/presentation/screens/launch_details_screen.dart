import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spacex_graphql/data/models/launch_model.dart';
import 'package:spacex_graphql/presentation/bloc/launch_details/launch_details_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/launch_details/launch_details_event.dart';
import 'package:spacex_graphql/presentation/bloc/launch_details/launch_details_state.dart';
import 'package:spacex_graphql/presentation/widgets/error_view.dart';
import 'package:spacex_graphql/presentation/widgets/loading_view.dart';
import 'package:spacex_graphql/presentation/widgets/app_network_image.dart';

class LaunchDetailsScreen extends StatefulWidget {
  final String launchId;

  const LaunchDetailsScreen({
    super.key,
    required this.launchId,
  });

  @override
  State<LaunchDetailsScreen> createState() => _LaunchDetailsScreenState();
}

class _LaunchDetailsScreenState extends State<LaunchDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LaunchDetailsBloc>().add(FetchLaunchDetails(widget.launchId));
  }

  void _retry() {
    context.read<LaunchDetailsBloc>().add(FetchLaunchDetails(widget.launchId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch Details'),
      ),
      body: BlocBuilder<LaunchDetailsBloc, LaunchDetailsState>(
        builder: (context, state) {
          if (state is LaunchDetailsLoading) {
            return const LoadingView();
          }

          if (state is LaunchDetailsError) {
            return ErrorView(
              message: state.message,
              onRetry: _retry,
            );
          }

          if (state is LaunchDetailsLoaded) {
            return _buildLaunchDetails(state.launch);
          }

          return ErrorView(
            message: 'Something went wrong',
            onRetry: _retry,
          );
        },
      ),
    );
  }

  Widget _buildLaunchDetails(LaunchModel launch) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(launch),
          _buildMissionDetails(launch),
          _buildMediaSection(launch),
          _buildRocketDetails(launch),
          _buildLaunchSiteMap(launch),
          _buildLinks(launch),
        ],
      ),
    );
  }

  Widget _buildHeader(LaunchModel launch) {
    final dateFormat = DateFormat('MMMM d, yyyy HH:mm');
    final launchDate = DateTime.parse(launch.launchDateLocal);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (launch.links.missionPatch != null)
            Center(
              child: AppNetworkImage(
                imageUrl: launch.links.missionPatch!,
                width: 150,
                height: 150,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            launch.missionName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            dateFormat.format(launchDate),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: launch.launchSuccess == true
                      ? Colors.green
                      : launch.launchSuccess == false
                          ? Colors.red
                          : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  launch.launchSuccess == true
                      ? 'Successful'
                      : launch.launchSuccess == false
                          ? 'Failed'
                          : 'Unknown',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              if (launch.upcoming)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Upcoming',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissionDetails(LaunchModel launch) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mission Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (launch.details != null)
            Text(
              launch.details!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          const SizedBox(height: 16),
          Text(
            'Launch Site: ${launch.launchSite?.siteNameLong ?? 'Unknown'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection(LaunchModel launch) {
    if (launch.links.flickrImages.isEmpty && launch.links.videoLink == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Media',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          if (launch.links.flickrImages.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: launch.links.flickrImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AppNetworkImage(
                        imageUrl: launch.links.flickrImages[index],
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          if (launch.links.videoLink != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _launchUrl(launch.links.videoLink!),
              icon: const Icon(Icons.play_circle_outline),
              label: const Text('Watch Launch Video'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRocketDetails(LaunchModel launch) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rocket Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${launch.rocket.rocketName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Type: ${launch.rocket.rocketType}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (launch.rocket.firstStage?.cores?.isNotEmpty == true) ...[
                    const SizedBox(height: 16),
                    Text(
                      'First Stage Cores:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...launch.rocket.firstStage!.cores!.map((core) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Flight: ${core.flight ?? 'Unknown'}'),
                            Text('Reused: ${core.reused == true ? 'Yes' : 'No'}'),
                            if (core.landSuccess != null)
                              Text('Landing Success: ${core.landSuccess == true ? 'Yes' : 'No'}'),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLaunchSiteMap(LaunchModel launch) {
    if (launch.launchSite == null) {
      return const SizedBox.shrink();
    }

    // TODO: Implement actual coordinates for launch sites
    // This is a placeholder with Kennedy Space Center coordinates
    const latLng = LatLng(28.5728722, -80.6489808);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Launch Site',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('launch_site'),
                    position: latLng,
                    infoWindow: InfoWindow(
                      title: launch.launchSite!.siteNameLong,
                    ),
                  ),
                },
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinks(LaunchModel launch) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Links',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (launch.links.articleLink != null)
                _buildLinkButton(
                  'Article',
                  Icons.article,
                  launch.links.articleLink!,
                ),
              if (launch.links.wikipedia != null)
                _buildLinkButton(
                  'Wikipedia',
                  Icons.public,
                  launch.links.wikipedia!,
                ),
              if (launch.links.presskit != null)
                _buildLinkButton(
                  'Press Kit',
                  Icons.description,
                  launch.links.presskit!,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(String label, IconData icon, String url) {
    return ElevatedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }
}

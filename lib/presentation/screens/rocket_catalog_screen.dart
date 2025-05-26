import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spacex_graphql/presentation/bloc/rocket/rocket_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/rocket/rocket_state.dart';

class RocketCatalogScreen extends StatefulWidget {
  const RocketCatalogScreen({super.key});

  @override
  State<RocketCatalogScreen> createState() => _RocketCatalogScreenState();
}

class _RocketCatalogScreenState extends State<RocketCatalogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RocketBloc>().loadRockets();
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildSpecificationCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RocketBloc, RocketState>(
      builder: (context, state) {
        if (state is RocketLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RocketError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<RocketBloc>().loadRockets();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is RocketLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Rocket Catalog'),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rocket List
                    Expanded(
                      flex: 1,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: ListView.builder(
                          itemCount: state.rockets.length,
                          itemBuilder: (context, index) {
                            final rocket = state.rockets[index];
                            return ListTile(
                              title: Text(rocket.name),
                              subtitle: Text(rocket.type),
                              selected: state.selectedRocket?.id == rocket.id,
                              onTap: () {
                                context.read<RocketBloc>().selectRocket(rocket);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 2,
                    child: AnimatedSlide(
                      offset: state.selectedRocket != null ? const Offset(0, 0) : const Offset(1, 0),
                      duration: const Duration(milliseconds: 300),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          // Rocket Details
                          Expanded(
                            flex: 2,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: state.selectedRocket == null
                                  ? const Center(
                                      child: Text(
                                        'Select a rocket to view details',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      key: ValueKey(state.selectedRocket?.id),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Images
                                          if (state.selectedRocket?.flickrImages?.isNotEmpty ?? false)
                                            AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              height: 200,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount:
                                                    state.selectedRocket?.flickrImages?.length ?? 0,
                                                itemBuilder: (context, index) {
                                                  final imageUrl =
                                                      state.selectedRocket?.flickrImages?[index];
                                                  if (imageUrl == null) return const SizedBox.shrink();
                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 8),
                                                    child: Hero(
                                                      tag:
                                                          'rocket_image_${state.selectedRocket?.id}_$index',
                                                      child: Image.network(
                                                        imageUrl,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          const SizedBox(height: 16),
                                          // Name and Type
                                          AnimatedDefaultTextStyle(
                                            duration: const Duration(milliseconds: 300),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            child: Text(state.selectedRocket?.name ?? ''),
                                          ),
                                          AnimatedDefaultTextStyle(
                                            duration: const Duration(milliseconds: 300),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                            child: Text(state.selectedRocket?.type ?? ''),
                                          ),
                                          const SizedBox(height: 16),
                                          // Description
                                          if (state.selectedRocket?.description != null) ...[
                                            AnimatedDefaultTextStyle(
                                              duration: const Duration(milliseconds: 300),
                                              style: const TextStyle(fontSize: 16),
                                              child: Text(state.selectedRocket?.description ?? ''),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                          // Specifications
                                          _buildSpecificationCard(
                                            'Dimensions',
                                            [
                                              if (state.selectedRocket?.height != null)
                                                _buildSpecificationRow(
                                                  'Height',
                                                  '${state.selectedRocket?.height} m',
                                                ),
                                              if (state.selectedRocket?.mass != null)
                                                _buildSpecificationRow(
                                                  'Mass',
                                                  '${state.selectedRocket?.mass} kg',
                                                ),
                                              if (state.selectedRocket?.diameter != null)
                                                _buildSpecificationRow(
                                                  'Diameter',
                                                  '${state.selectedRocket?.diameter} m',
                                                ),
                                            ],
                                          ),
                                          _buildSpecificationCard(
                                            'Performance',
                                            [
                                              if (state.selectedRocket?.stages != null)
                                                _buildSpecificationRow(
                                                  'Stages',
                                                  state.selectedRocket?.stages.toString() ?? '',
                                                ),
                                              if (state.selectedRocket?.boosters != null)
                                                _buildSpecificationRow(
                                                  'Boosters',
                                                  state.selectedRocket?.boosters.toString() ?? '',
                                                ),
                                              if (state.selectedRocket?.costPerLaunch != null)
                                                _buildSpecificationRow(
                                                  'Cost per Launch',
                                                  '\$${state.selectedRocket?.costPerLaunch}M',
                                                ),
                                              if (state.selectedRocket?.successRatePct != null)
                                                _buildSpecificationRow(
                                                  'Success Rate',
                                                  '${state.selectedRocket?.successRatePct}%',
                                                ),
                                            ],
                                          ),
                                          _buildSpecificationCard(
                                            'Engine Details',
                                            [
                                              if (state.selectedRocket?.engineType != null)
                                                _buildSpecificationRow(
                                                  'Type',
                                                  state.selectedRocket?.engineType ?? '',
                                                ),
                                              if (state.selectedRocket?.engineVersion != null)
                                                _buildSpecificationRow(
                                                  'Version',
                                                  state.selectedRocket?.engineVersion ?? '',
                                                ),
                                              if (state.selectedRocket?.engineNumber != null)
                                                _buildSpecificationRow(
                                                  'Number of Engines',
                                                  state.selectedRocket?.engineNumber.toString() ?? '',
                                                ),
                                              if (state.selectedRocket?.engineLayout != null)
                                                _buildSpecificationRow(
                                                  'Layout',
                                                  state.selectedRocket?.engineLayout ?? '',
                                                ),
                                              if (state.selectedRocket?.enginePropellant1 != null)
                                                _buildSpecificationRow(
                                                  'Propellant 1',
                                                  state.selectedRocket?.enginePropellant1 ?? '',
                                                ),
                                              if (state.selectedRocket?.enginePropellant2 != null)
                                                _buildSpecificationRow(
                                                  'Propellant 2',
                                                  state.selectedRocket?.enginePropellant2 ?? '',
                                                ),
                                            ],
                                          ),
                                          _buildSpecificationCard(
                                            'Stage Details',
                                            [
                                              if (state.selectedRocket?.firstStageEngines != null)
                                                _buildSpecificationRow(
                                                  'First Stage Engines',
                                                  state.selectedRocket?.firstStageEngines.toString() ??
                                                      '',
                                                ),
                                              if (state.selectedRocket?.firstStageFuelAmountTons != null)
                                                _buildSpecificationRow(
                                                  'First Stage Fuel',
                                                  '${state.selectedRocket?.firstStageFuelAmountTons} tons',
                                                ),
                                              if (state.selectedRocket?.firstStageBurnTimeSec != null)
                                                _buildSpecificationRow(
                                                  'First Stage Burn Time',
                                                  '${state.selectedRocket?.firstStageBurnTimeSec} sec',
                                                ),
                                              if (state.selectedRocket?.secondStageEngines != null)
                                                _buildSpecificationRow(
                                                  'Second Stage Engines',
                                                  state.selectedRocket?.secondStageEngines.toString() ??
                                                      '',
                                                ),
                                              if (state.selectedRocket?.secondStageFuelAmountTons !=
                                                  null)
                                                _buildSpecificationRow(
                                                  'Second Stage Fuel',
                                                  '${state.selectedRocket?.secondStageFuelAmountTons} tons',
                                                ),
                                            ],
                                          ),
                                          _buildSpecificationCard(
                                            'Additional Information',
                                            [
                                              if (state.selectedRocket?.firstFlight != null)
                                                _buildSpecificationRow(
                                                  'First Flight',
                                                  state.selectedRocket?.firstFlight ?? '',
                                                ),
                                              if (state.selectedRocket?.country != null)
                                                _buildSpecificationRow(
                                                  'Country',
                                                  state.selectedRocket?.country ?? '',
                                                ),
                                              if (state.selectedRocket?.company != null)
                                                _buildSpecificationRow(
                                                  'Company',
                                                  state.selectedRocket?.company ?? '',
                                                ),
                                              _buildSpecificationRow(
                                                'Status',
                                                state.selectedRocket?.active == true
                                                    ? 'Active'
                                                    : 'Inactive',
                                              ),
                                            ],
                                          ),
                                          // Wikipedia Link
                                          if (state.selectedRocket?.wikipedia != null) ...[
                                            const SizedBox(height: 16),
                                            ElevatedButton.icon(
                                              onPressed: () =>
                                                  _launchUrl(state.selectedRocket?.wikipedia ?? ''),
                                              icon: const Icon(Icons.language),
                                              label: const Text('View on Wikipedia'),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                                         
                        ],
                      ),
                    ),
                  )
                ],
              ),
            
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_bloc.dart';
import 'package:spacex_graphql/presentation/widgets/error_view.dart';
import 'package:spacex_graphql/presentation/widgets/loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketCatalogScreen extends StatefulWidget {
  const RocketCatalogScreen({super.key});

  @override
  State<RocketCatalogScreen> createState() => _RocketCatalogScreenState();
}

class _RocketCatalogScreenState extends State<RocketCatalogScreen> {
  List<RocketModel> _rockets = [];
  bool _isLoading = true;
  String? _error;
  RocketModel? _selectedRocket;

  @override
  void initState() {
    super.initState();
    _loadRockets();
  }

  Future<void> _loadRockets() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final rockets = await context.read<LaunchBloc>().repository.getRockets();
      setState(() {
        _rockets = rockets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showRocketDetails(RocketModel rocket) {
    setState(() {
      _selectedRocket = rocket;
    });
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingView();
    }

    if (_error != null) {
      return ErrorView(
        message: _error!,
        onRetry: _loadRockets,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Catalog'),
      ),
      body: Row(
        children: [
          // Rocket List
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _rockets.length,
              itemBuilder: (context, index) {
                final rocket = _rockets[index];
                return ListTile(
                  title: Text(rocket.name),
                  subtitle: Text(rocket.type),
                  selected: _selectedRocket?.id == rocket.id,
                  onTap: () => _showRocketDetails(rocket),
                );
              },
            ),
          ),
          // Rocket Details
          if (_selectedRocket != null)
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rocket Images
                    if (_selectedRocket!.flickrImages?.isNotEmpty ?? false)
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: _selectedRocket!.flickrImages!.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: _selectedRocket!.flickrImages![index],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 24),
                    // Rocket Name and Type
                    Text(
                      _selectedRocket!.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      _selectedRocket!.type,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    // Description
                    if (_selectedRocket!.description != null) ...[
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(_selectedRocket!.description!),
                      const SizedBox(height: 16),
                    ],
                    // Specifications
                    Text(
                      'Specifications',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    _buildSpecificationCard(),
                    const SizedBox(height: 16),
                    // Links
                    if (_selectedRocket!.wikipedia != null)
                      ElevatedButton.icon(
                        onPressed: () => _launchUrl(_selectedRocket!.wikipedia!),
                        icon: const Icon(Icons.language),
                        label: const Text('View on Wikipedia'),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSpecificationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Physical Specifications'),
            _buildSpecificationRow('Height',
                '${_selectedRocket!.height?.toStringAsFixed(1)} m (${_selectedRocket!.heightFeet?.toStringAsFixed(1)} ft)'),
            _buildSpecificationRow('Mass',
                '${_selectedRocket!.mass?.toStringAsFixed(0)} kg (${_selectedRocket!.massLb?.toStringAsFixed(0)} lb)'),
            _buildSpecificationRow('Diameter',
                '${_selectedRocket!.diameter?.toStringAsFixed(1)} m (${_selectedRocket!.diameterFeet?.toStringAsFixed(1)} ft)'),
            const SizedBox(height: 16),
            _buildSectionTitle('Engine Specifications'),
            _buildSpecificationRow('Engine Type', _selectedRocket!.engineType),
            _buildSpecificationRow('Engine Version', _selectedRocket!.engineVersion),
            _buildSpecificationRow('Number of Engines', _selectedRocket!.engineNumber?.toString()),
            _buildSpecificationRow('Engine Layout', _selectedRocket!.engineLayout),
            _buildSpecificationRow('Propellants',
                '${_selectedRocket!.enginePropellant1} / ${_selectedRocket!.enginePropellant2}'),
            _buildSpecificationRow('Thrust (Sea Level)',
                '${_selectedRocket!.engineThrustSeaLevelKn?.toStringAsFixed(0)} kN (${_selectedRocket!.engineThrustSeaLevelLbf?.toStringAsFixed(0)} lbf)'),
            _buildSpecificationRow('Thrust (Vacuum)',
                '${_selectedRocket!.engineThrustVacuumKn?.toStringAsFixed(0)} kN (${_selectedRocket!.engineThrustVacuumLbf?.toStringAsFixed(0)} lbf)'),
            _buildSpecificationRow(
                'Thrust to Weight', _selectedRocket!.engineThrustToWeight?.toString()),
            const SizedBox(height: 16),
            _buildSectionTitle('Stage Information'),
            _buildSpecificationRow('Stages', _selectedRocket!.stages?.toString()),
            _buildSpecificationRow('Boosters', _selectedRocket!.boosters?.toString()),
            _buildSpecificationRow(
                'First Stage Engines', _selectedRocket!.firstStageEngines?.toString()),
            _buildSpecificationRow('First Stage Fuel',
                '${_selectedRocket!.firstStageFuelAmountTons?.toStringAsFixed(1)} tons'),
            _buildSpecificationRow(
                'First Stage Burn Time', '${_selectedRocket!.firstStageBurnTimeSec} seconds'),
            _buildSpecificationRow(
                'First Stage Reusable', _selectedRocket!.firstStageReusable == true ? 'Yes' : 'No'),
            _buildSpecificationRow(
                'Second Stage Engines', _selectedRocket!.secondStageEngines?.toString()),
            _buildSpecificationRow('Second Stage Fuel',
                '${_selectedRocket!.secondStageFuelAmountTons?.toStringAsFixed(1)} tons'),
            _buildSpecificationRow(
                'Second Stage Burn Time', '${_selectedRocket!.secondStageBurnTimeSec} seconds'),
            _buildSpecificationRow('Second Stage Thrust',
                '${_selectedRocket!.secondStageThrustKn?.toStringAsFixed(0)} kN (${_selectedRocket!.secondStageThrustLbf?.toStringAsFixed(0)} lbf)'),
            const SizedBox(height: 16),
            _buildSectionTitle('Landing Information'),
            _buildSpecificationRow('Landing Legs',
                '${_selectedRocket!.landingLegsNumber} (${_selectedRocket!.landingLegsMaterial ?? 'N/A'})'),
            const SizedBox(height: 16),
            _buildSectionTitle('Payload Information'),
            if (_selectedRocket!.payloadWeights != null)
              ..._selectedRocket!.payloadWeights!.map((payload) => _buildSpecificationRow(
                    payload.name,
                    '${payload.kg.toStringAsFixed(0)} kg (${payload.lb.toStringAsFixed(0)} lb)',
                  )),
            const SizedBox(height: 16),
            _buildSectionTitle('Other Information'),
            _buildSpecificationRow(
                'Cost per Launch', '\$${_selectedRocket!.costPerLaunch?.toStringAsFixed(0)}'),
            _buildSpecificationRow('Success Rate', '${_selectedRocket!.successRatePct}%'),
            _buildSpecificationRow('First Flight', _selectedRocket!.firstFlight),
            _buildSpecificationRow('Country', _selectedRocket!.country),
            _buildSpecificationRow('Company', _selectedRocket!.company),
            _buildSpecificationRow('Status', _selectedRocket!.active == true ? 'Active' : 'Retired'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String? value) {
    if (value == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

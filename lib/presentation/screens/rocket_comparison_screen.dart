import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';
import 'package:spacex_graphql/presentation/bloc/launch/launch_bloc.dart';
import 'package:spacex_graphql/presentation/widgets/error_view.dart';
import 'package:spacex_graphql/presentation/widgets/loading_view.dart';

class RocketComparisonScreen extends StatefulWidget {
  const RocketComparisonScreen({super.key});

  @override
  State<RocketComparisonScreen> createState() => _RocketComparisonScreenState();
}

class _RocketComparisonScreenState extends State<RocketComparisonScreen> {
  List<RocketModel> _rockets = [];
  bool _isLoading = true;
  String? _error;
  RocketModel? _rocket1;
  RocketModel? _rocket2;

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
        title: const Text('Rocket Comparison'),
      ),
      body: Column(
        children: [
          // Rocket Selection
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<RocketModel?>(
                    decoration: const InputDecoration(
                      labelText: 'Select First Rocket',
                    ),
                    value: _rocket1,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Select a rocket')),
                      ..._rockets.map((rocket) => DropdownMenuItem(
                            value: rocket,
                            child: Text(rocket.name),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _rocket1 = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<RocketModel?>(
                    decoration: const InputDecoration(
                      labelText: 'Select Second Rocket',
                    ),
                    value: _rocket2,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Select a rocket')),
                      ..._rockets.map((rocket) => DropdownMenuItem(
                            value: rocket,
                            child: Text(rocket.name),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _rocket2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Comparison Table
          if (_rocket1 != null && _rocket2 != null)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildComparisonSection('Basic Information', [
                      _buildComparisonRow('Name', _rocket1!.name, _rocket2!.name),
                      _buildComparisonRow('Type', _rocket1!.type, _rocket2!.type),
                      _buildComparisonRow('Status', _rocket1!.active == true ? 'Active' : 'Retired',
                          _rocket2!.active == true ? 'Active' : 'Retired'),
                      _buildComparisonRow('Company', _rocket1!.company, _rocket2!.company),
                      _buildComparisonRow('Country', _rocket1!.country, _rocket2!.country),
                      _buildComparisonRow('First Flight', _rocket1!.firstFlight, _rocket2!.firstFlight),
                    ]),
                    _buildComparisonSection('Physical Specifications', [
                      _buildComparisonRow(
                          'Height',
                          '${_rocket1!.height?.toStringAsFixed(1)} m (${_rocket1!.heightFeet?.toStringAsFixed(1)} ft)',
                          '${_rocket2!.height?.toStringAsFixed(1)} m (${_rocket2!.heightFeet?.toStringAsFixed(1)} ft)'),
                      _buildComparisonRow(
                          'Mass',
                          '${_rocket1!.mass?.toStringAsFixed(0)} kg (${_rocket1!.massLb?.toStringAsFixed(0)} lb)',
                          '${_rocket2!.mass?.toStringAsFixed(0)} kg (${_rocket2!.massLb?.toStringAsFixed(0)} lb)'),
                      _buildComparisonRow(
                          'Diameter',
                          '${_rocket1!.diameter?.toStringAsFixed(1)} m (${_rocket1!.diameterFeet?.toStringAsFixed(1)} ft)',
                          '${_rocket2!.diameter?.toStringAsFixed(1)} m (${_rocket2!.diameterFeet?.toStringAsFixed(1)} ft)'),
                    ]),
                    _buildComparisonSection('Engine Specifications', [
                      _buildComparisonRow('Engine Type', _rocket1!.engineType, _rocket2!.engineType),
                      _buildComparisonRow(
                          'Engine Version', _rocket1!.engineVersion, _rocket2!.engineVersion),
                      _buildComparisonRow('Number of Engines', _rocket1!.engineNumber?.toString(),
                          _rocket2!.engineNumber?.toString()),
                      _buildComparisonRow(
                          'Engine Layout', _rocket1!.engineLayout, _rocket2!.engineLayout),
                      _buildComparisonRow(
                          'Propellants',
                          '${_rocket1!.enginePropellant1} / ${_rocket1!.enginePropellant2}',
                          '${_rocket2!.enginePropellant1} / ${_rocket2!.enginePropellant2}'),
                      _buildComparisonRow(
                          'Thrust (Sea Level)',
                          '${_rocket1!.engineThrustSeaLevelKn?.toStringAsFixed(0)} kN (${_rocket1!.engineThrustSeaLevelLbf?.toStringAsFixed(0)} lbf)',
                          '${_rocket2!.engineThrustSeaLevelKn?.toStringAsFixed(0)} kN (${_rocket2!.engineThrustSeaLevelLbf?.toStringAsFixed(0)} lbf)'),
                      _buildComparisonRow(
                          'Thrust (Vacuum)',
                          '${_rocket1!.engineThrustVacuumKn?.toStringAsFixed(0)} kN (${_rocket1!.engineThrustVacuumLbf?.toStringAsFixed(0)} lbf)',
                          '${_rocket2!.engineThrustVacuumKn?.toStringAsFixed(0)} kN (${_rocket2!.engineThrustVacuumLbf?.toStringAsFixed(0)} lbf)'),
                      _buildComparisonRow('Thrust to Weight', _rocket1!.engineThrustToWeight?.toString(),
                          _rocket2!.engineThrustToWeight?.toString()),
                    ]),
                    _buildComparisonSection('Stage Information', [
                      _buildComparisonRow(
                          'Stages', _rocket1!.stages?.toString(), _rocket2!.stages?.toString()),
                      _buildComparisonRow(
                          'Boosters', _rocket1!.boosters?.toString(), _rocket2!.boosters?.toString()),
                      _buildComparisonRow('First Stage Engines', _rocket1!.firstStageEngines?.toString(),
                          _rocket2!.firstStageEngines?.toString()),
                      _buildComparisonRow(
                          'First Stage Fuel',
                          '${_rocket1!.firstStageFuelAmountTons?.toStringAsFixed(1)} tons',
                          '${_rocket2!.firstStageFuelAmountTons?.toStringAsFixed(1)} tons'),
                      _buildComparisonRow(
                          'First Stage Burn Time',
                          '${_rocket1!.firstStageBurnTimeSec} seconds',
                          '${_rocket2!.firstStageBurnTimeSec} seconds'),
                      _buildComparisonRow(
                          'First Stage Reusable',
                          _rocket1!.firstStageReusable == true ? 'Yes' : 'No',
                          _rocket2!.firstStageReusable == true ? 'Yes' : 'No'),
                      _buildComparisonRow(
                          'Second Stage Engines',
                          _rocket1!.secondStageEngines?.toString(),
                          _rocket2!.secondStageEngines?.toString()),
                      _buildComparisonRow(
                          'Second Stage Fuel',
                          '${_rocket1!.secondStageFuelAmountTons?.toStringAsFixed(1)} tons',
                          '${_rocket2!.secondStageFuelAmountTons?.toStringAsFixed(1)} tons'),
                      _buildComparisonRow(
                          'Second Stage Burn Time',
                          '${_rocket1!.secondStageBurnTimeSec} seconds',
                          '${_rocket2!.secondStageBurnTimeSec} seconds'),
                      _buildComparisonRow(
                          'Second Stage Thrust',
                          '${_rocket1!.secondStageThrustKn?.toStringAsFixed(0)} kN (${_rocket1!.secondStageThrustLbf?.toStringAsFixed(0)} lbf)',
                          '${_rocket2!.secondStageThrustKn?.toStringAsFixed(0)} kN (${_rocket2!.secondStageThrustLbf?.toStringAsFixed(0)} lbf)'),
                    ]),
                    _buildComparisonSection('Landing Information', [
                      _buildComparisonRow(
                          'Landing Legs',
                          '${_rocket1!.landingLegsNumber} (${_rocket1!.landingLegsMaterial ?? 'N/A'})',
                          '${_rocket2!.landingLegsNumber} (${_rocket2!.landingLegsMaterial ?? 'N/A'})'),
                    ]),
                    _buildComparisonSection('Payload Information', [
                      ..._buildPayloadComparison(),
                    ]),
                    _buildComparisonSection('Other Information', [
                      _buildComparisonRow(
                          'Cost per Launch',
                          '\$${_rocket1!.costPerLaunch?.toStringAsFixed(0)}',
                          '\$${_rocket2!.costPerLaunch?.toStringAsFixed(0)}'),
                      _buildComparisonRow('Success Rate', '${_rocket1!.successRatePct}%',
                          '${_rocket2!.successRatePct}%'),
                    ]),
                  ],
                ),
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('Select two rockets to compare'),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildPayloadComparison() {
    final List<Widget> rows = [];
    final Set<String> allPayloadTypes = {
      ...?_rocket1?.payloadWeights?.map((p) => p.id),
      ...?_rocket2?.payloadWeights?.map((p) => p.id),
    };

    for (final payloadId in allPayloadTypes) {
      final payload1 = _rocket1?.payloadWeights?.firstWhere(
        (p) => p.id == payloadId,
        orElse: () => PayloadWeight(id: payloadId, name: 'N/A', kg: 0, lb: 0),
      );
      final payload2 = _rocket2?.payloadWeights?.firstWhere(
        (p) => p.id == payloadId,
        orElse: () => PayloadWeight(id: payloadId, name: 'N/A', kg: 0, lb: 0),
      );

      if (payload1 != null || payload2 != null) {
        rows.add(_buildComparisonRow(
          payload1?.name ?? payload2?.name ?? payloadId,
          payload1 != null
              ? '${payload1.kg.toStringAsFixed(0)} kg (${payload1.lb.toStringAsFixed(0)} lb)'
              : 'N/A',
          payload2 != null
              ? '${payload2.kg.toStringAsFixed(0)} kg (${payload2.lb.toStringAsFixed(0)} lb)'
              : 'N/A',
        ));
      }
    }

    return rows;
  }

  Widget _buildComparisonSection(String title, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...rows,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildComparisonRow(String label, String? value1, String? value2) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value1 ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    value2 ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

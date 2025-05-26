import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_graphql/data/models/rocket_model.dart';
import 'package:spacex_graphql/presentation/bloc/rocket/rocket_bloc.dart';
import 'package:spacex_graphql/presentation/bloc/rocket/rocket_state.dart';

class RocketComparisonScreen extends StatefulWidget {
  const RocketComparisonScreen({super.key});

  @override
  State<RocketComparisonScreen> createState() => _RocketComparisonScreenState();
}

class _RocketComparisonScreenState extends State<RocketComparisonScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RocketBloc>().loadRockets();
  }

  Widget _buildComparisonRow(String label, String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _formatValue(dynamic value, String unit) {
    if (value == null) return 'N/A';
    return '$value $unit';
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
              title: const Text('Rocket Comparison'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<RocketModel>(
                          decoration: const InputDecoration(
                            labelText: 'Rocket 1',
                            border: OutlineInputBorder(),
                          ),
                          value: state.selectedRocket,
                          items: state.rockets.map((rocket) {
                            return DropdownMenuItem(
                              value: rocket,
                              child: Text(rocket.name),
                            );
                          }).toList(),
                          onChanged: (rocket) {
                            if (rocket != null) {
                              context.read<RocketBloc>().selectRocket(rocket);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<RocketModel>(
                          decoration: const InputDecoration(
                            labelText: 'Rocket 2',
                            border: OutlineInputBorder(),
                          ),
                          value: state.comparisonRocket,
                          items: state.rockets.map((rocket) {
                            return DropdownMenuItem(
                              value: rocket,
                              child: Text(rocket.name),
                            );
                          }).toList(),
                          onChanged: (rocket) {
                            if (rocket != null) {
                              context.read<RocketBloc>().selectComparisonRocket(rocket);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state.selectedRocket != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildComparisonRow(
                              'Name',
                              state.selectedRocket!.name,
                              state.comparisonRocket?.name ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Type',
                              state.selectedRocket!.type,
                              state.comparisonRocket?.type ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Height',
                              _formatValue(state.selectedRocket!.height, 'm'),
                              state.comparisonRocket != null
                                  ? _formatValue(state.comparisonRocket!.height, 'm')
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Mass',
                              _formatValue(state.selectedRocket!.mass, 'kg'),
                              state.comparisonRocket != null
                                  ? _formatValue(state.comparisonRocket!.mass, 'kg')
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Diameter',
                              _formatValue(state.selectedRocket!.diameter, 'm'),
                              state.comparisonRocket != null
                                  ? _formatValue(state.comparisonRocket!.diameter, 'm')
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Stages',
                              state.selectedRocket!.stages?.toString() ?? 'N/A',
                              state.comparisonRocket?.stages?.toString() ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Boosters',
                              state.selectedRocket!.boosters?.toString() ?? 'N/A',
                              state.comparisonRocket?.boosters?.toString() ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Cost per Launch',
                              state.selectedRocket!.costPerLaunch != null
                                  ? '\$${state.selectedRocket!.costPerLaunch}M'
                                  : 'N/A',
                              state.comparisonRocket?.costPerLaunch != null
                                  ? '\$${state.comparisonRocket!.costPerLaunch}M'
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Success Rate',
                              state.selectedRocket!.successRatePct != null
                                  ? '${state.selectedRocket!.successRatePct}%'
                                  : 'N/A',
                              state.comparisonRocket?.successRatePct != null
                                  ? '${state.comparisonRocket!.successRatePct}%'
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'First Flight',
                              state.selectedRocket!.firstFlight ?? 'N/A',
                              state.comparisonRocket?.firstFlight ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Country',
                              state.selectedRocket!.country ?? 'N/A',
                              state.comparisonRocket?.country ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Company',
                              state.selectedRocket!.company ?? 'N/A',
                              state.comparisonRocket?.company ?? 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Status',
                              state.selectedRocket!.active == true ? 'Active' : 'Inactive',
                              state.comparisonRocket != null
                                  ? (state.comparisonRocket!.active == true ? 'Active' : 'Inactive')
                                  : 'Select Rocket 2',
                            ),
                            _buildComparisonRow(
                              'Description',
                              state.selectedRocket!.description ?? 'N/A',
                              state.comparisonRocket?.description ?? 'Select Rocket 2',
                            ),
                          ],
                        ),
                      ),
                    ),
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

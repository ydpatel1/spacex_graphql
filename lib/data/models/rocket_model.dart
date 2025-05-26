class RocketModel {
  final String id;
  final String name;
  final String type;
  final String? description;
  final double? height;
  final double? heightFeet;
  final double? mass;
  final double? massLb;
  final double? diameter;
  final double? diameterFeet;
  final int? stages;
  final int? boosters;
  final double? costPerLaunch;
  final int? successRatePct;
  final String? firstFlight;
  final String? country;
  final String? company;
  final List<String>? flickrImages;
  final String? wikipedia;
  final bool? active;

  // Engine details
  final String? engineType;
  final String? engineVersion;
  final int? engineNumber;
  final String? engineLayout;
  final String? enginePropellant1;
  final String? enginePropellant2;
  final String? engineLossMax;
  final double? engineThrustToWeight;
  final double? engineThrustSeaLevelKn;
  final double? engineThrustSeaLevelLbf;
  final double? engineThrustVacuumKn;
  final double? engineThrustVacuumLbf;

  // Stage details
  final int? firstStageEngines;
  final double? firstStageFuelAmountTons;
  final int? firstStageBurnTimeSec;
  final bool? firstStageReusable;
  final int? secondStageEngines;
  final double? secondStageFuelAmountTons;
  final int? secondStageBurnTimeSec;
  final double? secondStageThrustKn;
  final double? secondStageThrustLbf;

  // Landing legs
  final int? landingLegsNumber;
  final String? landingLegsMaterial;

  // Payload weights
  final List<PayloadWeight>? payloadWeights;

  const RocketModel({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    this.height,
    this.heightFeet,
    this.mass,
    this.massLb,
    this.diameter,
    this.diameterFeet,
    this.stages,
    this.boosters,
    this.costPerLaunch,
    this.successRatePct,
    this.firstFlight,
    this.country,
    this.company,
    this.flickrImages,
    this.wikipedia,
    this.active,
    this.engineType,
    this.engineVersion,
    this.engineNumber,
    this.engineLayout,
    this.enginePropellant1,
    this.enginePropellant2,
    this.engineLossMax,
    this.engineThrustToWeight,
    this.engineThrustSeaLevelKn,
    this.engineThrustSeaLevelLbf,
    this.engineThrustVacuumKn,
    this.engineThrustVacuumLbf,
    this.firstStageEngines,
    this.firstStageFuelAmountTons,
    this.firstStageBurnTimeSec,
    this.firstStageReusable,
    this.secondStageEngines,
    this.secondStageFuelAmountTons,
    this.secondStageBurnTimeSec,
    this.secondStageThrustKn,
    this.secondStageThrustLbf,
    this.landingLegsNumber,
    this.landingLegsMaterial,
    this.payloadWeights,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) {
    return RocketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      height: (json['height']?['meters'] as num?)?.toDouble(),
      heightFeet: (json['height']?['feet'] as num?)?.toDouble(),
      mass: (json['mass']?['kg'] as num?)?.toDouble(),
      massLb: (json['mass']?['lb'] as num?)?.toDouble(),
      diameter: (json['diameter']?['meters'] as num?)?.toDouble(),
      diameterFeet: (json['diameter']?['feet'] as num?)?.toDouble(),
      stages: json['stages'] as int?,
      boosters: json['boosters'] as int?,
      costPerLaunch: (json['cost_per_launch'] as num?)?.toDouble(),
      successRatePct: json['success_rate_pct'] as int?,
      firstFlight: json['first_flight'] as String?,
      country: json['country'] as String?,
      company: json['company'] as String?,
      flickrImages: (json['flickr_images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      wikipedia: json['wikipedia'] as String?,
      active: json['active'] as bool?,
      engineType: json['engines']?['type'] as String?,
      engineVersion: json['engines']?['version'] as String?,
      engineNumber: json['engines']?['number'] as int?,
      engineLayout: json['engines']?['layout'] as String?,
      enginePropellant1: json['engines']?['propellant_1'] as String?,
      enginePropellant2: json['engines']?['propellant_2'] as String?,
      engineLossMax: json['engines']?['engine_loss_max'] as String?,
      engineThrustToWeight: (json['engines']?['thrust_to_weight'] as num?)?.toDouble(),
      engineThrustSeaLevelKn: (json['engines']?['thrust_sea_level']?['kN'] as num?)?.toDouble(),
      engineThrustSeaLevelLbf: (json['engines']?['thrust_sea_level']?['lbf'] as num?)?.toDouble(),
      engineThrustVacuumKn: (json['engines']?['thrust_vacuum']?['kN'] as num?)?.toDouble(),
      engineThrustVacuumLbf: (json['engines']?['thrust_vacuum']?['lbf'] as num?)?.toDouble(),
      firstStageEngines: json['first_stage']?['engines'] as int?,
      firstStageFuelAmountTons: (json['first_stage']?['fuel_amount_tons'] as num?)?.toDouble(),
      firstStageBurnTimeSec: json['first_stage']?['burn_time_sec'] as int?,
      firstStageReusable: json['first_stage']?['reusable'] as bool?,
      secondStageEngines: json['second_stage']?['engines'] as int?,
      secondStageFuelAmountTons: (json['second_stage']?['fuel_amount_tons'] as num?)?.toDouble(),
      secondStageBurnTimeSec: json['second_stage']?['burn_time_sec'] as int?,
      secondStageThrustKn: (json['second_stage']?['thrust']?['kN'] as num?)?.toDouble(),
      secondStageThrustLbf: (json['second_stage']?['thrust']?['lbf'] as num?)?.toDouble(),
      landingLegsNumber: json['landing_legs']?['number'] as int?,
      landingLegsMaterial: json['landing_legs']?['material'] as String?,
      payloadWeights: (json['payload_weights'] as List<dynamic>?)
          ?.map((e) => PayloadWeight.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'height': height != null ? {'meters': height, 'feet': heightFeet} : null,
      'mass': mass != null ? {'kg': mass, 'lb': massLb} : null,
      'diameter': diameter != null ? {'meters': diameter, 'feet': diameterFeet} : null,
      'stages': stages,
      'boosters': boosters,
      'cost_per_launch': costPerLaunch,
      'success_rate_pct': successRatePct,
      'first_flight': firstFlight,
      'country': country,
      'company': company,
      'flickr_images': flickrImages,
      'wikipedia': wikipedia,
      'active': active,
      'engines': {
        'type': engineType,
        'version': engineVersion,
        'number': engineNumber,
        'layout': engineLayout,
        'propellant_1': enginePropellant1,
        'propellant_2': enginePropellant2,
        'engine_loss_max': engineLossMax,
        'thrust_to_weight': engineThrustToWeight,
        'thrust_sea_level': {
          'kN': engineThrustSeaLevelKn,
          'lbf': engineThrustSeaLevelLbf,
        },
        'thrust_vacuum': {
          'kN': engineThrustVacuumKn,
          'lbf': engineThrustVacuumLbf,
        },
      },
      'first_stage': {
        'engines': firstStageEngines,
        'fuel_amount_tons': firstStageFuelAmountTons,
        'burn_time_sec': firstStageBurnTimeSec,
        'reusable': firstStageReusable,
      },
      'second_stage': {
        'engines': secondStageEngines,
        'fuel_amount_tons': secondStageFuelAmountTons,
        'burn_time_sec': secondStageBurnTimeSec,
        'thrust': {
          'kN': secondStageThrustKn,
          'lbf': secondStageThrustLbf,
        },
      },
      'landing_legs': {
        'number': landingLegsNumber,
        'material': landingLegsMaterial,
      },
      'payload_weights': payloadWeights?.map((e) => e.toJson()).toList(),
    };
  }
}

class PayloadWeight {
  final String id;
  final String name;
  final double kg;
  final double lb;

  const PayloadWeight({
    required this.id,
    required this.name,
    required this.kg,
    required this.lb,
  });

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(
      id: json['id'] as String,
      name: json['name'] as String,
      kg: (json['kg'] as num).toDouble(),
      lb: (json['lb'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'kg': kg,
      'lb': lb,
    };
  }
}

import 'package:equatable/equatable.dart';

class RequestLaunchModel extends Equatable {
  final LaunchFindModel? find;
  final int? limit;
  final int? offset;
  final String? order;
  final String? sort;

  const RequestLaunchModel({
    this.find,
    this.limit,
    this.offset,
    this.order,
    this.sort,
  });

  factory RequestLaunchModel.fromJson(Map<String, dynamic> json) {
    return RequestLaunchModel(
      find: json['find'] != null ? LaunchFindModel.fromJson(json['find']) : null,
      limit: json['limit'],
      offset: json['offset'],
      order: json['order'],
      sort: json['sort'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (find != null) 'find': find?.toJson(),
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (order != null) 'order': order,
      if (sort != null) 'sort': sort,
    };
  }

  @override
  List<Object?> get props => [find, limit, offset, order, sort];
}

class LaunchFindModel extends Equatable {
  final double? apoapsisKm;
  final int? block;
  final String? capSerial;
  final bool? capsuleReuse;
  final int? coreFlight;
  final bool? coreReuse;
  final String? coreSerial;
  final String? customer;
  final double? eccentricity;
  final String? end;
  final String? epoch;
  final bool? fairingsRecovered;
  final bool? fairingsRecoveryAttempt;
  final bool? fairingsReuse;
  final bool? fairingsReused;
  final String? fairingsShip;
  final bool? gridfins;
  final String? id;
  final bool? tentative;
  final String? tentativeMaxPrecision;
  final double? inclinationDeg;
  final bool? landSuccess;
  final bool? landingIntent;
  final String? landingType;
  final String? landingVehicle;
  final String? launchDateLocal;
  final String? launchDateUtc;
  final bool? launchSuccess;
  final String? launchYear;
  final bool? legs;
  final double? lifespanYears;
  final double? longitude;
  final String? manufacturer;
  final double? meanMotion;
  final List<String>? missionId;
  final String? missionName;
  final String? nationality;
  final int? noradId;
  final String? orbit;
  final String? payloadId;
  final String? payloadType;
  final double? periapsisKm;
  final double? periodMin;
  final double? raan;
  final String? referenceSystem;
  final String? regime;
  final bool? reused;
  final String? rocketId;
  final String? rocketName;
  final String? rocketType;
  final String? secondStageBlock;
  final double? semiMajorAxisKm;
  final String? ship;
  final bool? sideCore1Reuse;
  final bool? sideCore2Reuse;
  final String? siteId;
  final String? siteNameLong;
  final String? siteName;
  final String? start;
  final bool? tbd;

  const LaunchFindModel({
    this.apoapsisKm,
    this.block,
    this.capSerial,
    this.capsuleReuse,
    this.coreFlight,
    this.coreReuse,
    this.coreSerial,
    this.customer,
    this.eccentricity,
    this.end,
    this.epoch,
    this.fairingsRecovered,
    this.fairingsRecoveryAttempt,
    this.fairingsReuse,
    this.fairingsReused,
    this.fairingsShip,
    this.gridfins,
    this.id,
    this.tentative,
    this.tentativeMaxPrecision,
    this.inclinationDeg,
    this.landSuccess,
    this.landingIntent,
    this.landingType,
    this.landingVehicle,
    this.launchDateLocal,
    this.launchDateUtc,
    this.launchSuccess,
    this.launchYear,
    this.legs,
    this.lifespanYears,
    this.longitude,
    this.manufacturer,
    this.meanMotion,
    this.missionId,
    this.missionName,
    this.nationality,
    this.noradId,
    this.orbit,
    this.payloadId,
    this.payloadType,
    this.periapsisKm,
    this.periodMin,
    this.raan,
    this.referenceSystem,
    this.regime,
    this.reused,
    this.rocketId,
    this.rocketName,
    this.rocketType,
    this.secondStageBlock,
    this.semiMajorAxisKm,
    this.ship,
    this.sideCore1Reuse,
    this.sideCore2Reuse,
    this.siteId,
    this.siteNameLong,
    this.siteName,
    this.start,
    this.tbd,
  });

  factory LaunchFindModel.fromJson(Map<String, dynamic> json) {
    return LaunchFindModel(
      apoapsisKm: json['apoapsis_km']?.toDouble(),
      block: json['block'],
      capSerial: json['cap_serial'],
      capsuleReuse: json['capsule_reuse'],
      coreFlight: json['core_flight'],
      coreReuse: json['core_reuse'],
      coreSerial: json['core_serial'],
      customer: json['customer'],
      eccentricity: json['eccentricity']?.toDouble(),
      end: json['end'],
      epoch: json['epoch'],
      fairingsRecovered: json['fairings_recovered'],
      fairingsRecoveryAttempt: json['fairings_recovery_attempt'],
      fairingsReuse: json['fairings_reuse'],
      fairingsReused: json['fairings_reused'],
      fairingsShip: json['fairings_ship'],
      gridfins: json['gridfins'],
      id: json['id'],
      tentative: json['tentative'],
      tentativeMaxPrecision: json['tentative_max_precision'],
      inclinationDeg: json['inclination_deg']?.toDouble(),
      landSuccess: json['land_success'],
      landingIntent: json['landing_intent'],
      landingType: json['landing_type'],
      landingVehicle: json['landing_vehicle'],
      launchDateLocal: json['launch_date_local'],
      launchDateUtc: json['launch_date_utc'],
      launchSuccess: json['launch_success'],
      launchYear: json['launch_year'],
      legs: json['legs'],
      lifespanYears: json['lifespan_years']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      manufacturer: json['manufacturer'],
      meanMotion: json['mean_motion']?.toDouble(),
      missionId: (json['mission_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      missionName: json['mission_name'],
      nationality: json['nationality'],
      noradId: json['norad_id'],
      orbit: json['orbit'],
      payloadId: json['payload_id'],
      payloadType: json['payload_type'],
      periapsisKm: json['periapsis_km']?.toDouble(),
      periodMin: json['period_min']?.toDouble(),
      raan: json['raan']?.toDouble(),
      referenceSystem: json['reference_system'],
      regime: json['regime'],
      reused: json['reused'],
      rocketId: json['rocket_id'],
      rocketName: json['rocket_name'],
      rocketType: json['rocket_type'],
      secondStageBlock: json['second_stage_block'],
      semiMajorAxisKm: json['semi_major_axis_km']?.toDouble(),
      ship: json['ship'],
      sideCore1Reuse: json['side_core1_reuse'],
      sideCore2Reuse: json['side_core2_reuse'],
      siteId: json['site_id'],
      siteNameLong: json['site_name_long'],
      siteName: json['site_name'],
      start: json['start'],
      tbd: json['tbd'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apoapsis_km': apoapsisKm,
      'block': block,
      'cap_serial': capSerial,
      'capsule_reuse': capsuleReuse,
      'core_flight': coreFlight,
      'core_reuse': coreReuse,
      'core_serial': coreSerial,
      'customer': customer,
      'eccentricity': eccentricity,
      'end': end,
      'epoch': epoch,
      'fairings_recovered': fairingsRecovered,
      'fairings_recovery_attempt': fairingsRecoveryAttempt,
      'fairings_reuse': fairingsReuse,
      'fairings_reused': fairingsReused,
      'fairings_ship': fairingsShip,
      'gridfins': gridfins,
      'id': id,
      'tentative': tentative,
      'tentative_max_precision': tentativeMaxPrecision,
      'inclination_deg': inclinationDeg,
      'land_success': landSuccess,
      'landing_intent': landingIntent,
      'landing_type': landingType,
      'landing_vehicle': landingVehicle,
      'launch_date_local': launchDateLocal,
      'launch_date_utc': launchDateUtc,
      'launch_success': launchSuccess?.toString(),
      'launch_year': launchYear,
      'legs': legs,
      'lifespan_years': lifespanYears,
      'longitude': longitude,
      'manufacturer': manufacturer,
      'mean_motion': meanMotion,
      'mission_id': missionId,
      'mission_name': missionName,
      'nationality': nationality,
      'norad_id': noradId,
      'orbit': orbit,
      'payload_id': payloadId,
      'payload_type': payloadType,
      'periapsis_km': periapsisKm,
      'period_min': periodMin,
      'raan': raan,
      'reference_system': referenceSystem,
      'regime': regime,
      'reused': reused,
      'rocket_id': rocketId,
      'rocket_name': rocketName,
      'rocket_type': rocketType,
      'second_stage_block': secondStageBlock,
      'semi_major_axis_km': semiMajorAxisKm,
      'ship': ship,
      'side_core1_reuse': sideCore1Reuse,
      'side_core2_reuse': sideCore2Reuse,
      'site_id': siteId,
      'site_name_long': siteNameLong,
      'site_name': siteName,
      'start': start,
      'tbd': tbd,
    };
  }

  @override
  List<Object?> get props => [
        apoapsisKm,
        block,
        capSerial,
        capsuleReuse,
        coreFlight,
        coreReuse,
        coreSerial,
        customer,
        eccentricity,
        end,
        epoch,
        fairingsRecovered,
        fairingsRecoveryAttempt,
        fairingsReuse,
        fairingsReused,
        fairingsShip,
        gridfins,
        id,
        tentative,
        tentativeMaxPrecision,
        inclinationDeg,
        landSuccess,
        landingIntent,
        landingType,
        landingVehicle,
        launchDateLocal,
        launchDateUtc,
        launchSuccess,
        launchYear,
        legs,
        lifespanYears,
        longitude,
        manufacturer,
        meanMotion,
        missionId,
        missionName,
        nationality,
        noradId,
        orbit,
        payloadId,
        payloadType,
        periapsisKm,
        periodMin,
        raan,
        referenceSystem,
        regime,
        reused,
        rocketId,
        rocketName,
        rocketType,
        secondStageBlock,
        semiMajorAxisKm,
        ship,
        sideCore1Reuse,
        sideCore2Reuse,
        siteId,
        siteNameLong,
        siteName,
        start,
        tbd,
      ];
}

import 'package:equatable/equatable.dart';

class LaunchModel extends Equatable {
  final String id;
  final String? details;
  final bool? isTentative;
  final String launchDateLocal;
  final int launchDateUnix;
  final String launchDateUtc;
  final LaunchSite? launchSite;
  final bool? launchSuccess;
  final String launchYear;
  final LaunchLinks links;
  final List<String> missionId;
  final String missionName;
  final Rocket rocket;
  final int? staticFireDateUnix;
  final String? staticFireDateUtc;
  final Telemetry? telemetry;
  final String? tentativeMaxPrecision;
  final bool upcoming;

  const LaunchModel({
    required this.id,
    this.details,
    this.isTentative,
    required this.launchDateLocal,
    required this.launchDateUnix,
    required this.launchDateUtc,
    this.launchSite,
    this.launchSuccess,
    required this.launchYear,
    required this.links,
    required this.missionId,
    required this.missionName,
    required this.rocket,
    this.staticFireDateUnix,
    this.staticFireDateUtc,
    this.telemetry,
    this.tentativeMaxPrecision,
    required this.upcoming,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      id: json['id'] as String,
      details: json['details'] as String?,
      isTentative: json['is_tentative'] as bool?,
      launchDateLocal: json['launch_date_local'] as String,
      launchDateUnix: json['launch_date_unix'] as int,
      launchDateUtc: json['launch_date_utc'] as String,
      launchSite: json['launch_site'] != null
          ? LaunchSite.fromJson(json['launch_site'] as Map<String, dynamic>)
          : null,
      launchSuccess: json['launch_success'] as bool?,
      launchYear: json['launch_year'] as String,
      links: LaunchLinks.fromJson(json['links'] as Map<String, dynamic>),
      missionId: (json['mission_id'] as List<dynamic>).map((e) => e as String).toList(),
      missionName: json['mission_name'] as String,
      rocket: Rocket.fromJson(json['rocket'] as Map<String, dynamic>),
      staticFireDateUnix: json['static_fire_date_unix'] as int?,
      staticFireDateUtc: json['static_fire_date_utc'] as String?,
      telemetry: json['telemetry'] != null
          ? Telemetry.fromJson(json['telemetry'] as Map<String, dynamic>)
          : null,
      tentativeMaxPrecision: json['tentative_max_precision'] as String?,
      upcoming: json['upcoming'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'is_tentative': isTentative,
      'launch_date_local': launchDateLocal,
      'launch_date_unix': launchDateUnix,
      'launch_date_utc': launchDateUtc,
      'launch_site': launchSite?.toJson(),
      'launch_success': launchSuccess,
      'launch_year': launchYear,
      'links': links.toJson(),
      'mission_id': missionId,
      'mission_name': missionName,
      'rocket': rocket.toJson(),
      'static_fire_date_unix': staticFireDateUnix,
      'static_fire_date_utc': staticFireDateUtc,
      'telemetry': telemetry?.toJson(),
      'tentative_max_precision': tentativeMaxPrecision,
      'upcoming': upcoming,
    };
  }

  @override
  List<Object?> get props => [
        id,
        details,
        isTentative,
        launchDateLocal,
        launchDateUnix,
        launchDateUtc,
        launchSite,
        launchSuccess,
        launchYear,
        links,
        missionId,
        missionName,
        rocket,
        staticFireDateUnix,
        staticFireDateUtc,
        telemetry,
        tentativeMaxPrecision,
        upcoming,
      ];
}

class LaunchSite extends Equatable {
  final String? siteId;
  final String? siteName;
  final String? siteNameLong;

  const LaunchSite({
    this.siteId,
    this.siteName,
    this.siteNameLong,
  });

  factory LaunchSite.fromJson(Map<String, dynamic> json) {
    return LaunchSite(
      siteId: json['site_id'] as String?,
      siteName: json['site_name'] as String?,
      siteNameLong: json['site_name_long'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_id': siteId,
      'site_name': siteName,
      'site_name_long': siteNameLong,
    };
  }

  @override
  List<Object?> get props => [siteId, siteName, siteNameLong];
}

class LaunchLinks extends Equatable {
  final String? articleLink;
  final List<String> flickrImages;
  final String? missionPatch;
  final String? missionPatchSmall;
  final String? presskit;
  final String? redditCampaign;
  final String? redditLaunch;
  final String? redditMedia;
  final String? redditRecovery;
  final String? videoLink;
  final String? wikipedia;

  const LaunchLinks({
    this.articleLink,
    required this.flickrImages,
    this.missionPatch,
    this.missionPatchSmall,
    this.presskit,
    this.redditCampaign,
    this.redditLaunch,
    this.redditMedia,
    this.redditRecovery,
    this.videoLink,
    this.wikipedia,
  });

  factory LaunchLinks.fromJson(Map<String, dynamic> json) {
    return LaunchLinks(
      articleLink: json['article_link'] as String?,
      flickrImages: (json['flickr_images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      missionPatch: json['mission_patch'] as String?,
      missionPatchSmall: json['mission_patch_small'] as String?,
      presskit: json['presskit'] as String?,
      redditCampaign: json['reddit_campaign'] as String?,
      redditLaunch: json['reddit_launch'] as String?,
      redditMedia: json['reddit_media'] as String?,
      redditRecovery: json['reddit_recovery'] as String?,
      videoLink: json['video_link'] as String?,
      wikipedia: json['wikipedia'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_link': articleLink,
      'flickr_images': flickrImages,
      'mission_patch': missionPatch,
      'mission_patch_small': missionPatchSmall,
      'presskit': presskit,
      'reddit_campaign': redditCampaign,
      'reddit_launch': redditLaunch,
      'reddit_media': redditMedia,
      'reddit_recovery': redditRecovery,
      'video_link': videoLink,
      'wikipedia': wikipedia,
    };
  }

  @override
  List<Object?> get props => [
        articleLink,
        flickrImages,
        missionPatch,
        missionPatchSmall,
        presskit,
        redditCampaign,
        redditLaunch,
        redditMedia,
        redditRecovery,
        videoLink,
        wikipedia,
      ];
}

class Rocket extends Equatable {
  final Fairings? fairings;
  final FirstStage? firstStage;
  final String rocketName;
  final String rocketType;

  const Rocket({
    this.fairings,
    this.firstStage,
    required this.rocketName,
    required this.rocketType,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      fairings:
          json['fairings'] != null ? Fairings.fromJson(json['fairings'] as Map<String, dynamic>) : null,
      firstStage: json['first_stage'] != null
          ? FirstStage.fromJson(json['first_stage'] as Map<String, dynamic>)
          : null,
      rocketName: json['rocket_name'] as String,
      rocketType: json['rocket_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fairings': fairings?.toJson(),
      'first_stage': firstStage?.toJson(),
      'rocket_name': rocketName,
      'rocket_type': rocketType,
    };
  }

  @override
  List<Object?> get props => [fairings, firstStage, rocketName, rocketType];
}

class Fairings extends Equatable {
  final bool? recovered;
  final bool? recoveryAttempt;
  final bool? reused;
  final String? ship;

  const Fairings({
    this.recovered,
    this.recoveryAttempt,
    this.reused,
    this.ship,
  });

  factory Fairings.fromJson(Map<String, dynamic> json) {
    return Fairings(
      recovered: json['recovered'] as bool?,
      recoveryAttempt: json['recovery_attempt'] as bool?,
      reused: json['reused'] as bool?,
      ship: json['ship'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recovered': recovered,
      'recovery_attempt': recoveryAttempt,
      'reused': reused,
      'ship': ship,
    };
  }

  @override
  List<Object?> get props => [recovered, recoveryAttempt, reused, ship];
}

class FirstStage extends Equatable {
  final List<Core>? cores;

  const FirstStage({
    this.cores,
  });

  factory FirstStage.fromJson(Map<String, dynamic> json) {
    return FirstStage(
      cores: json['cores'] != null
          ? (json['cores'] as List<dynamic>)
              .map((e) => Core.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cores': cores?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [cores];
}

class Core extends Equatable {
  final int? block;
  final CoreDetails? core;
  final int? flight;
  final bool? gridfins;
  final bool? landSuccess;
  final bool? landingIntent;
  final String? landingType;
  final String? landingVehicle;
  final bool? legs;
  final bool? reused;

  const Core({
    this.block,
    this.core,
    this.flight,
    this.gridfins,
    this.landSuccess,
    this.landingIntent,
    this.landingType,
    this.landingVehicle,
    this.legs,
    this.reused,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      block: json['block'] as int?,
      core: json['core'] != null ? CoreDetails.fromJson(json['core'] as Map<String, dynamic>) : null,
      flight: json['flight'] as int?,
      gridfins: json['gridfins'] as bool?,
      landSuccess: json['land_success'] as bool?,
      landingIntent: json['landing_intent'] as bool?,
      landingType: json['landing_type'] as String?,
      landingVehicle: json['landing_vehicle'] as String?,
      legs: json['legs'] as bool?,
      reused: json['reused'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block': block,
      'core': core?.toJson(),
      'flight': flight,
      'gridfins': gridfins,
      'land_success': landSuccess,
      'landing_intent': landingIntent,
      'landing_type': landingType,
      'landing_vehicle': landingVehicle,
      'legs': legs,
      'reused': reused,
    };
  }

  @override
  List<Object?> get props => [
        block,
        core,
        flight,
        gridfins,
        landSuccess,
        landingIntent,
        landingType,
        landingVehicle,
        legs,
        reused,
      ];
}

class CoreDetails extends Equatable {
  final int? asdsAttempts;
  final int? asdsLandings;
  final int? block;
  final String? id;
  final List<Mission>? missions;
  final String? originalLaunch;
  final int? reuseCount;
  final int? rtlsAttempts;
  final int? rtlsLandings;
  final String? status;
  final bool? waterLanding;

  const CoreDetails({
    this.asdsAttempts,
    this.asdsLandings,
    this.block,
    this.id,
    this.missions,
    this.originalLaunch,
    this.reuseCount,
    this.rtlsAttempts,
    this.rtlsLandings,
    this.status,
    this.waterLanding,
  });

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
      asdsAttempts: json['asds_attempts'] as int?,
      asdsLandings: json['asds_landings'] as int?,
      block: json['block'] as int?,
      id: json['id'] as String?,
      missions: json['missions'] != null
          ? (json['missions'] as List<dynamic>)
              .map((e) => Mission.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      originalLaunch: json['original_launch'] as String?,
      reuseCount: json['reuse_count'] as int?,
      rtlsAttempts: json['rtls_attempts'] as int?,
      rtlsLandings: json['rtls_landings'] as int?,
      status: json['status'] as String?,
      waterLanding: json['water_landing'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asds_attempts': asdsAttempts,
      'asds_landings': asdsLandings,
      'block': block,
      'id': id,
      'missions': missions?.map((e) => e.toJson()).toList(),
      'original_launch': originalLaunch,
      'reuse_count': reuseCount,
      'rtls_attempts': rtlsAttempts,
      'rtls_landings': rtlsLandings,
      'status': status,
      'water_landing': waterLanding,
    };
  }

  @override
  List<Object?> get props => [
        asdsAttempts,
        asdsLandings,
        block,
        id,
        missions,
        originalLaunch,
        reuseCount,
        rtlsAttempts,
        rtlsLandings,
        status,
        waterLanding,
      ];
}

class Mission extends Equatable {
  final int? flight;
  final String? name;

  const Mission({
    this.flight,
    this.name,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      flight: json['flight'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flight': flight,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [flight, name];
}

class Telemetry extends Equatable {
  final String? flightClub;

  const Telemetry({
    this.flightClub,
  });

  factory Telemetry.fromJson(Map<String, dynamic> json) {
    return Telemetry(
      flightClub: json['flight_club'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flight_club': flightClub,
    };
  }

  @override
  List<Object?> get props => [flightClub];
}

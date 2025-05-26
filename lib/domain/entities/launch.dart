class Launch {
  final String id;
  final String missionName;
  final DateTime launchDate;
  final bool success;
  final String? missionPatch;
  final String rocketName;
  final String launchSiteName;
  final String? details;
  final List<String>? images;
  final String? videoUrl;

  const Launch({
    required this.id,
    required this.missionName,
    required this.launchDate,
    required this.success,
    this.missionPatch,
    required this.rocketName,
    required this.launchSiteName,
    this.details,
    this.images,
    this.videoUrl,
  });
}

class RocketModel {
  final String id;
  final String name;
  final String type;

  const RocketModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) {
    return RocketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }
}

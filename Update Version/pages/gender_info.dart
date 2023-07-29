class GenderInfo {
  String name;
  String gender;
  double probability;
  int count;

  GenderInfo({
    required this.name,
    required this.gender,
    required this.probability,
    required this.count,
  });

  factory GenderInfo.fromJson(Map<String, dynamic> json) {
    return GenderInfo(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'],
      count: json['count'],
    );
  }
}

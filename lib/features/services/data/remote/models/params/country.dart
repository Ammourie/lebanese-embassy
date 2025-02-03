class CountryModel {
  final String code;
  final String name;

  CountryModel({required this.code, required this.name});

  // Convert from JSON
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}

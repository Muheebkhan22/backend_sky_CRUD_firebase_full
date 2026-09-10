class CityModel {
  final String? docId;
  final String countryID;
  final String? cityName;
  final List<dynamic>? saved;
  final int? population;
  final bool? visited;
  final DateTime? createdAt;

  CityModel({
    this.docId,
    required this.countryID,
    this.cityName,
    this.saved,
    this.population,
    this.visited,
    this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      docId: json["docId"],
      countryID: json["countryID"] ?? "",
      cityName: json["cityName"],
      saved: json["saved"] ?? [],
      population: json["population"],
      visited: json["visited"] ?? false,
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson(String cityId) {
    return {
      "docId": cityId,
      "countryID": countryID,
      "cityName": cityName,
      "saved": saved ?? [],
      "population": population,
      "visited": visited ?? false,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}

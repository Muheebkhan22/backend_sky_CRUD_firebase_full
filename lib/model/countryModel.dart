// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

class CountryModel {
  final String? docId;
  final String? country;
  final DateTime? createdAt;

  CountryModel({
    this.docId,
    this.country,
    this.createdAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        docId: json["docId"],
        country: json["country"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson(String countryID) => {
        "docId": countryID,
        "country": country,
        "createdAt": createdAt?.toIso8601String(),
      };
}

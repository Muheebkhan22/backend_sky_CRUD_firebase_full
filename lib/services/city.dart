import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';

class CityService {
  String cityCollection = "CityCollection";

  // CREATE CITY
  Future createCity(CityModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(cityCollection).doc();

    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(documentReference.id)
        .set(
          model.toJson(documentReference.id),
        );
  }

  // UPDATE CITY
  Future updateCity(CityModel model) async {
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .update({
      "cityName": model.cityName,
      "population": model.population,
    });
  }

  // DELETE CITY
  Future deleteCity(String cityId) async {
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityId)
        .delete();
  }

  // MARK CITY
  Future markCity(String cityId, bool visited) async {
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityId)
        .update({
      "visited": visited,
    });
  }

  // GET ALL CITY
  Stream<List<CityModel>> getAllCities() {
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (cityList) => cityList.docs
              .map(
                (cityJson) => CityModel.fromJson(cityJson.data()),
              )
              .toList(),
        );
  }

  // GET VISITED CITIES
  Stream<List<CityModel>> getVisitedCity() {
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (cityList) => cityList.docs
              .map(
                (cityJson) => CityModel.fromJson(cityJson.data()),
              )
              .toList(),
        );
  }

  // GET UNVISITED CITIES
  Stream<List<CityModel>> getUnVisitedCities() {
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (cityList) => cityList.docs
              .map(
                (cityJson) => CityModel.fromJson(cityJson.data()),
              )
              .toList(),
        );
  }

  // GET CITY BY COUNTRY ID
  Stream<List<CityModel>> getCityByCountryID(String countryID) {
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where(
          "countryID",
          isEqualTo: countryID,
        )
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (cityList) => cityList.docs
              .map(
                (cityJson) => CityModel.fromJson(cityJson.data()),
              )
              .toList(),
        );
  }

  ///get all saved favrate
  Stream<List<CityModel>> getAllSavedCities(String userID) {
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("saved" , arrayContains: userID)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (cityList) => cityList.docs
              .map(
                (cityJson) => CityModel.fromJson(cityJson.data()),
              )
              .toList(),
        );
  }

  ///add to saved favirate wala
  Future addToSaved({required String userID, required String cityID}) async {
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityID)
        .update({
      "saved": FieldValue.arrayUnion([userID])
    });
  }

  ///remove from saved favirate wla
   Future removeFromSaved({required String userID, required String cityID}) async {
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityID)
        .update({
      "saved": FieldValue.arrayRemove([userID])
    });
  }
}

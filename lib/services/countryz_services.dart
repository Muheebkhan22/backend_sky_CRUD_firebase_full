import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyz_islamabadz_backend/model/countryModel.dart';

class CountryzServices {
  String countryCollection = "countryCollection";
  //create ftn
  //update ftn
  //delete ftn
  //get ftn

  //create ftn
  Future createCountry(CountryModel model) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection(countryCollection).doc();
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  //update ftn
  Future updateCountry(CountryModel model) async {
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(model.docId)
        .update({"country": model.country});
  }

  //delete ftn
  Future deleteCountry(String countryID) async {
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(countryID)
        .delete();
  }

  //getAll country ftn
  Stream<List<CountryModel>> getallcountry() {
    return FirebaseFirestore.instance
        .collection(countryCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((countrylist) => countrylist.docs
            .map((coutryjson) => CountryModel.fromJson(coutryjson.data()))
            .toList());
  }

  //get Country concetion wla model dafra da
  Future<List<CountryModel>> getConties() async {
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .orderBy("createdAt", descending: true)
        .get()
        .then(
          (countryList) => countryList.docs
              .map(
                (countryJson) => CountryModel.fromJson(countryJson.data()),
              )
              .toList(),
        );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';
import 'package:skyz_islamabadz_backend/model/countryModel.dart';
import 'package:skyz_islamabadz_backend/services/city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/edit_city_screen.dart';

class GetCities extends StatelessWidget {
  final CountryModel model;
  const GetCities({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('${model.country}'),
        centerTitle: true,
      ),
      body: StreamProvider.value(
        value: CityService().getCityByCountryID(model.docId.toString()),
        initialData: [CityModel(countryID: "")],
        builder: (context, child) {
          List<CityModel> cityList = context.watch<List<CityModel>>();
          return ListView.builder(
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text(cityList[index].cityName.toString()),
                  subtitle: Text(cityList[index].population.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            try {
                              await CityService()
                                  .deleteCity(cityList[index].docId.toString());
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditCityScreen(
                                        model: cityList[index])));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

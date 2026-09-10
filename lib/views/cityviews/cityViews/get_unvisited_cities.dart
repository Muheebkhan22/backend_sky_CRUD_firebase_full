import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';
import 'package:skyz_islamabadz_backend/services/city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/create_city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/edit_city_screen.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/countryViews/getAll_country.dart';

class GetUnvisitedCity extends StatefulWidget {
  const GetUnvisitedCity({super.key});

  @override
  State<GetUnvisitedCity> createState() => _GetUnvisitedCity();
}

class _GetUnvisitedCity extends State<GetUnvisitedCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get UnVisited Cities'),
        centerTitle: true,
      ),
      body: StreamProvider<List<CityModel>>.value(
        value: CityService().getUnVisitedCities(),

        // IMPORTANT
        initialData: const [],

        builder: (context, child) {
          List<CityModel> cityList = context.watch<List<CityModel>>();

          if (cityList.isEmpty) {
            return const Center(
              child: Text(
                "No City Found",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (context, index) {
              final city = cityList[index];

              return ListTile(
                leading: Checkbox(
                  value: city.visited,
                  onChanged: (value) async {
                    try {
                      await CityService().markCity(
                        city.docId!,
                        value ?? false,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                ),
                title: Text(
                  city.cityName ?? "No City Name",
                ),
                subtitle: Text(
                  "Population: ${city.population ?? 0}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // DELETE
                    IconButton(
                      onPressed: () async {
                        try {
                          await CityService().deleteCity(
                            city.docId!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("City deleted successfully"),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),

                    // EDIT
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCityScreen(
                              model: city,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

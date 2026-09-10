import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';
import 'package:skyz_islamabadz_backend/services/city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/create_city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/edit_city_screen.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/get_all_save_cities.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/get_unvisited_cities.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/get_visited_cities.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/countryViews/getAll_country.dart';
import 'package:skyz_islamabadz_backend/views/profile/get_profile.dart';

class GetallCity extends StatefulWidget {
  const GetallCity({super.key});

  @override
  State<GetallCity> createState() => _GetallCityState();
}

class _GetallCityState extends State<GetallCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Cities'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetvisitedCity()));
              },
              icon: Icon(Icons.circle)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetUnvisitedCity()));
              },
              icon: Icon(Icons.incomplete_circle)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetallCountry()));
              },
              icon: Icon(Icons.location_city)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetallSavedCity()));
              },
              icon: Icon(Icons.bookmark)),
              
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetProfile()));
              },
              icon: Icon(Icons.person)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCity(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamProvider<List<CityModel>>.value(
        value: CityService().getAllCities(),

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
                    IconButton(
                        onPressed: () async {
                          if (cityList[index].saved!.contains("101")) {
                            await CityService().removeFromSaved(
                                userID: "101",
                                cityID: cityList[index].docId.toString());
                          } else {
                            await CityService().addToSaved(
                                userID: "101",
                                cityID: cityList[index].docId.toString());
                          }
                        },
                        icon: Icon(cityList[index].saved!.contains("101")
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined))
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

import 'package:flutter/material.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';
import 'package:skyz_islamabadz_backend/model/countryModel.dart';
import 'package:skyz_islamabadz_backend/services/city.dart';
import 'package:skyz_islamabadz_backend/services/countryz_services.dart';

class CreateCity extends StatefulWidget {
  const CreateCity({super.key});

  @override
  State<CreateCity> createState() => _CreateCityState();
}

class _CreateCityState extends State<CreateCity> {
  TextEditingController citynameController = TextEditingController();
  TextEditingController citypopulionconter = TextEditingController();
  List<CountryModel> countryList = [];
  CountryModel? selectedCountry;
  @override
  void initState() {
    super.initState();
    CountryzServices().getConties().then((value) {
      setState(() {
        countryList = value;
      });
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('create city data'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: citynameController,
              decoration: InputDecoration(
                  hintText: 'City Name',
                  fillColor: Colors.grey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: citypopulionconter,
              decoration: InputDecoration(
                  hintText: 'City pupulations',
                  fillColor: Colors.grey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButton(
                hint: Text('Selected Country'),
                value: selectedCountry,
                items: countryList.map((country) {
                  return DropdownMenuItem(
                      value: country, child: Text(country.country.toString()));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCountry = val;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await CityService()
                      .createCity(
                    CityModel(
                      countryID: selectedCountry!.docId.toString(),
                      cityName: citynameController.text,
                      population: int.parse(citypopulionconter.text),
                      visited: false,
                      createdAt: DateTime.now(),
                    ),
                  )
                      .then((value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Success"),
                          content: const Text("City Created Successfully"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Okay"),
                            ),
                          ],
                        );
                      },
                    );
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: Text('create city data'),
            )
          ],
        ),
      ),
    );
  }
}

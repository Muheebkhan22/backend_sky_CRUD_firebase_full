import 'package:flutter/material.dart';
import 'package:skyz_islamabadz_backend/model/cityModel.dart';
import 'package:skyz_islamabadz_backend/services/city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/getAll_city.dart';

class EditCityScreen extends StatefulWidget {
  final CityModel model;
  const EditCityScreen({super.key, required this.model});

  @override
  State<EditCityScreen> createState() => _EditCityScreenState();
}

class _EditCityScreenState extends State<EditCityScreen> {
  TextEditingController citynameController = TextEditingController();
  TextEditingController citypopulionconter = TextEditingController();

  @override
  void initState() {
    super.initState();
    citynameController =
        TextEditingController(text: widget.model.cityName.toString());
    citypopulionconter =
        TextEditingController(text: widget.model.population.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('update / edit city screen'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: citynameController,
            decoration: InputDecoration(
                hintText: 'city name edit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: citypopulionconter,
            decoration: InputDecoration(
                hintText: 'city population edit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await CityService().updateCity(CityModel(
                    countryID: widget.model.countryID
                        .toString(), //////-------------------> da wala ke changes osho
                    docId: widget.model.docId.toString(),
                    cityName: citynameController.text,
                    population: int.parse(citypopulionconter.text),
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(' successfuly update data')));
                  citynameController.clear();
                  citypopulionconter.clear();
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text('update')),
        ],
      ),
    );
  }
}

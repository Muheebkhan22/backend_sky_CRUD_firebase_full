import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/countryModel.dart';
import 'package:skyz_islamabadz_backend/services/countryz_services.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/get_cities.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/countryViews/createUpdate_country.dart';

class GetallCountry extends StatefulWidget {
  const GetallCountry({super.key});

  @override
  State<GetallCountry> createState() => _GetallCountryState();
}

class _GetallCountryState extends State<GetallCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Get All Country'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateupdateCountry(
                        isupdatedMode: false, model: CountryModel())));
          },
          child: Icon(Icons.add),
        ),
        body: StreamProvider.value(
          value: CountryzServices().getallcountry(),
          initialData: [CountryModel()],
          builder: (context, child) {
            List<CountryModel> countryList =
                context.watch<List<CountryModel>>();
            return ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text(countryList[index].country.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              try {
                                await CountryzServices().deleteCountry(
                                    countryList[index].docId.toString());
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
                                      builder: (context) => CreateupdateCountry(
                                          isupdatedMode: true,
                                          model: countryList[index])));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetCities(
                                          model: countryList[index])));
                            },
                            icon: Icon(Icons.arrow_forward)),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}

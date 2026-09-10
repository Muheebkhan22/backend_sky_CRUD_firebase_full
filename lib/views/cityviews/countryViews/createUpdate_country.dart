import 'package:flutter/material.dart';
import 'package:skyz_islamabadz_backend/model/countryModel.dart';
import 'package:skyz_islamabadz_backend/services/countryz_services.dart';

class CreateupdateCountry extends StatefulWidget {
  final bool isupdatedMode;
  final CountryModel model;
  const CreateupdateCountry(
      {super.key, required this.isupdatedMode, required this.model});

  @override
  State<CreateupdateCountry> createState() => _CreateupdateCountryState();
}

class _CreateupdateCountryState extends State<CreateupdateCountry> {
  TextEditingController nameController = TextEditingController();
  bool isload = false;
  @override
  void initState() {
    if (widget.isupdatedMode == true) {
      nameController = TextEditingController(
        text: widget.model.country.toString(),
      );
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title:
            Text(widget.isupdatedMode ? "Update Country " : "Create Country"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Country name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 10,
          ),
          isload
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('plese file field')));
                      return;
                    }
                    try {
                      isload = true;
                      setState(() {});
                      if (widget.isupdatedMode == true) {
                        await CountryzServices()
                            .updateCountry(CountryModel(
                          docId: widget.model.docId.toString(),
                          country: nameController.text,
                        ))
                            .then((value) {
                          isload = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text('update succefuly'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"))
                                  ],
                                );
                              });
                        });
                      } else {
                        await CountryzServices()
                            .createCountry(CountryModel(
                                country: nameController.text,
                                createdAt: DateTime.now()))
                            .then((value) {
                          isload = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text('Create Sucessfuly'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Okay'))
                                  ],
                                );
                              });
                        });
                      }
                    } catch (e) {
                      isload = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text(widget.isupdatedMode
                      ? "Update Country"
                      : "Create Country"))
        ],
      ),
    );
  }
}

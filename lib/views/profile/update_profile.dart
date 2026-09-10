import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/user.dart';
import 'package:skyz_islamabadz_backend/provider/user.dart';
import 'package:skyz_islamabadz_backend/services/user.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    nameController = TextEditingController(text: user?.name.toString());
    phoneController = TextEditingController(text: user?.phone.toString());
    addressController = TextEditingController(text: user?.address.toString());
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Enter Name"),
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Enter Number"),
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Enter Address"),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final currentUser = userProvider.user;
                      if (currentUser == null || currentUser.docId == null) {
                        throw "User Not Found";
                      }
                      UserModel updatedModel = UserModel(
                          docId: currentUser.docId,
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          email: currentUser.toString());

                      await UserService().updateUser(updatedModel);

                      UserModel freshUser =
                          await UserService().getUserByID(currentUser.docId!);
                      userProvider.setUser(freshUser);
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Updae Successfully"),
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
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Profile"))
        ],
      ),
    );
  }
}

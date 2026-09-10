import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/provider/user.dart';
import 'package:skyz_islamabadz_backend/views/profile/update_profile.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: user == null
            ? Center(
                child: Text("No Profile Data Found"),
              )
            : Column(
                children: [
                  Text("Name: ${user.name ?? "N/A"}"),
                  Text("Email: ${user.email ?? "N/A"}"),
                  Text("Phone: ${user.phone ?? "N/A"}"),
                  Text("Address: ${user.address ?? "N/A"}"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfile()));
                      },
                      child: Text("Edit Profile"))
                ],
              ));
  }
}

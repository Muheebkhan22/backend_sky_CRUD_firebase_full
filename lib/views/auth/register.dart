import 'package:flutter/material.dart';
import 'package:skyz_islamabadz_backend/model/user.dart';
import 'package:skyz_islamabadz_backend/services/auth.dart';
import 'package:skyz_islamabadz_backend/services/user.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hint: Text("Enter Name"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hint: Text("Enter Email"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hint: Text("Enter Password"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  hint: Text("Enter Phone"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                  hint: Text("Enter Address"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        isLoading = true;
                        setState(() {});
                        await AuthService()
                            .regiterUser(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) async {
                          await UserService()
                              .createUser(UserModel(
                                  docId: value!.uid.toString(),
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  createdAt:
                                      DateTime.now().millisecondsSinceEpoch))
                              .then((val) {
                            isLoading = false;
                            setState(() {});
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Register Successfully"),
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
                        });
                      } catch (e) {
                        isLoading = false;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text("Register"))
          ],
        ),
      ),
    );
  }
}

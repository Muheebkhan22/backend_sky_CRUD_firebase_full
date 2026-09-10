import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/model/user.dart';
import 'package:skyz_islamabadz_backend/provider/user.dart';
import 'package:skyz_islamabadz_backend/services/auth.dart';
import 'package:skyz_islamabadz_backend/services/user.dart';
import 'package:skyz_islamabadz_backend/views/auth/register.dart';
import 'package:skyz_islamabadz_backend/views/auth/reset_password.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/getAll_city.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hint: Text("Email"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hint: Text("Password"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                  },
                  child: Text("Forget Password ?")),
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
                            .loginUser(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) async {
                          if (value.emailVerified == true) {
                            await UserService()
                                .getUserByID(value.uid.toString())
                                .then((userModel) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(userModel);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetallCity()));
                            });
                          } else {
                            isLoading = false;
                            setState(() {});
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Kindly Verify Your Email"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          }
                        });
                      } catch (e) {
                        isLoading = false;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text("Login")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account ?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterUser()));
                    },
                    child: Text("SignUp"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

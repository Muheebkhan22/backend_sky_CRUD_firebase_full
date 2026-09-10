import 'package:flutter/material.dart';
import 'package:skyz_islamabadz_backend/services/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
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
                            .resetPassword(emailController.text)
                            .then((value) {
                          isLoading = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Link Send Successfully"),
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
                      } catch (e) {
                        isLoading = false;
                        setState(() {});
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text("Send Link"))
          ],
        ),
      ),
    );
  }
}

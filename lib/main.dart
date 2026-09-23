import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyz_islamabadz_backend/firebase_options.dart';
import 'package:skyz_islamabadz_backend/provider/user.dart';
import 'package:skyz_islamabadz_backend/views/auth/login.dart';
import 'package:skyz_islamabadz_backend/views/auth/register.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/create_city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/cityViews/getAll_city.dart';
import 'package:skyz_islamabadz_backend/views/cityviews/countryViews/getAll_country.dart';

void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: CreateCity(),
        home: LoginScreen());
  }
}

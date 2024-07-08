import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moviyee/Login_Screen.dart';
import 'package:moviyee/controllers/otpVerificationPage.dart';
import 'package:moviyee/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 34, 14, 179),
      ),
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moviyee/Screens/Login_Screen.dart';
import 'package:moviyee/constants.dart';

import 'package:moviyee/controllers/otpVerificationPage.dart';
import 'package:moviyee/controllers/firebase_folder/firebase_options.dart';

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
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: AppConstants.buttoncolor),
      home: ,
    );
  }
}

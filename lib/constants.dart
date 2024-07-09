import 'package:flutter/material.dart';

class AppConstants {
  static const Color buttoncolor = Color.fromARGB(255, 34, 14, 179);
  static const Color buttontext = Color.fromARGB(255, 255, 255, 255);
  static const Color errorColor = Colors.red;
   static const Color successColor = Colors.green; 
  static const Color textButtonColor = Color.fromARGB(255, 140, 128, 234);
}

class ButtonStyleConstants {
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppConstants.buttoncolor,
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    textStyle: const TextStyle(
      color: AppConstants.buttontext,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

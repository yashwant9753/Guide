import 'package:flutter/material.dart';

class CustomColors {
  static final Color firebaseOrange = Colors.black;
  static final Color firebaseAmber = Colors.white;
  static final Color firebaseYellow = Color(0xFFFFCA28);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color googleBackground = Color(0xFF4285F4);
  static final Color custumText = Colors.white;
  static final Color buttonColor = Colors.black;
}

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[900],
    primaryColorBrightness: Brightness.light,
    backgroundColor: Colors.grey[700]);

final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.grey,
    accentColor: Colors.blueAccent[400],
    primaryColorBrightness: Brightness.light,
    backgroundColor: Colors.grey[900]);

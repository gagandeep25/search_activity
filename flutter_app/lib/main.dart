import 'package:flutter/material.dart';
import 'package:flutterapp/search.dart';

void main() {
  runApp(MaterialApp(
    home: Search(),
    theme: ThemeData(
      buttonTheme: ButtonThemeData(
        minWidth: 60.0
      ),
    ),
  ));
}


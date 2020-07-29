import 'package:flutter/material.dart';
import 'package:flutterapp/search.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Search(),
    theme: ThemeData(
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.deepPurple[500])),
      buttonTheme: ButtonThemeData(minWidth: 60.0),
    ),
  ));
}

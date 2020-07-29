import './CustomDialog.dart';
import 'package:flutter/material.dart';

class DialogOnTap {
  static info(context, String name, String person, String number) => showDialog(
      context: context,
      builder: (context) => CustomDialog(name, person, number));
}

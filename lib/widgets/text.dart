import 'package:flutter/material.dart';

class Helper {
  static Widget text(
      String msg, int size, double spacing, Color color, FontWeight fontWeight) {
    return Text(
      msg,
      textAlign: TextAlign.left,
    );
  }
}

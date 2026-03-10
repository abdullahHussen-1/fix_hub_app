import 'package:flutter/material.dart';

class AppMediaQuery {
  static double sizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double sizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> showToastMsg({
    required String msg,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Fluttertoast.showToast(
      //todo msg show
      msg: msg,
      //todo show time long or short
      toastLength: Toast.LENGTH_SHORT,
      //todo location in screen
      gravity: ToastGravity.CENTER,
      //todo time show
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}

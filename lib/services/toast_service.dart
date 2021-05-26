import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static void showToast(String text, {Color bgColor = Colors.red}) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: bgColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
  }
}

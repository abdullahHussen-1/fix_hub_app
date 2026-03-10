import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.fontsize,
      required this.fontWeight,
      required this.color});
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

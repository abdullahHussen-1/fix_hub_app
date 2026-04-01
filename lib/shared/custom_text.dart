import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.fontsize,
      required this.fontWeight,
      required this.color,
      this.fontFamily,
      this.maxLines});

  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontFamily: fontFamily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

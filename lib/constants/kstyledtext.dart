import 'package:flutter/material.dart';

Text styledText({
  required String text,
  Color? color,
  TextDecoration? decoration,
  Color? decorationColor,
  FontWeight? weight,
  double? size = 20,
  double? lSpacing,
  double? wSpacing,
  double? height,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      letterSpacing: lSpacing,
      wordSpacing: wSpacing,
      color: color,
      fontWeight: weight,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: 1.86,
    ),
  );
}

import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final FontWeight? weight;
  final double? size;
  final double? lSpacing;
  final double? wSpacing;
  final double? height;
  const StyledText({
    super.key,
    required this.text,
    this.color,
    this.decoration,
    this.decorationColor,
    this.weight,
    this.size = 20,
    this.lSpacing,
    this.wSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
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
}

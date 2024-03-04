import 'package:flutter/material.dart';

class KActionButton extends StatelessWidget {
  final Function() onTap;
  final Widget? child;
  final String? text;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  const KActionButton({
    super.key,
    required this.onTap,
    this.text,
    this.color,
    this.height,
    this.width,
    this.radius,
    this.fontSize,
    this.child,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      height: height ?? 60,
      minWidth: width ?? double.maxFinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 15),
      ),
      textColor: Colors.white,
      child: child ??
          Text(
            text ?? 'Click Me',
            style: TextStyle(
              fontSize: fontSize ?? 18,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
    );
  }
}

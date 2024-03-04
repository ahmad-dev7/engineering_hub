import 'package:flutter/material.dart';

class KWidgetWrap extends StatelessWidget {
  final Widget child;
  final double? height;
  const KWidgetWrap({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    double deviceSize = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: deviceSize * (height ?? 0.030)),
      child: child,
    );
  }
}

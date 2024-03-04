import 'package:flutter/material.dart';

class KBackgroundImage extends StatelessWidget {
  final Widget child;
  final String? imagePath;
  const KBackgroundImage({
    super.key,
    required this.child,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          opacity: 0.3,
          fit: BoxFit.cover,
          image: AssetImage(
            imagePath ?? "images/mumbai_university.jpg",
          ),
        ),
      ),
      child: child,
    );
  }
}

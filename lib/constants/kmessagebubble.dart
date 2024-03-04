import 'package:flutter/material.dart';

class KMessageBubble extends StatelessWidget {
  const KMessageBubble({
    super.key,
    required this.thisUser,
    required this.child,
  });
  final bool thisUser;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
        color: thisUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: thisUser
              ? const Radius.circular(15)
              : const Radius.elliptical(2, 5),
          bottomRight: thisUser
              ? const Radius.elliptical(2, 5)
              : const Radius.circular(15),
        ),
      ),
      child: child,
    );
  }
}

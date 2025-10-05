import 'package:flutter/material.dart';

class WrapperContainer extends StatelessWidget {
  const WrapperContainer({super.key, this.color, required this.child});

  final Color? color; // optional
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      child: child,
    );
  }
}

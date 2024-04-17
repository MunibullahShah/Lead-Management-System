import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TopInfoBox extends StatelessWidget {
  final Color color;
  final Widget child;

  const TopInfoBox({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }
}

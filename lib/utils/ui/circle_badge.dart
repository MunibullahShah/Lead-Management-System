import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircleBadge extends StatelessWidget {

  final Color color;

  const CircleBadge({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 3.sp,
    );
  }
}

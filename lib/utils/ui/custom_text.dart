import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  String text;
  int? maxLines;
  TextOverflow? overflow;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  double fontSize;
  TextStyle? style;
  Color? color;

  CustomText({
    Key? key,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.fontWeight,
    required this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style ??
          TextStyle(
              fontFamily: 'Poppins',
              fontWeight: fontWeight,
              fontSize: fontSize.sp,
              color: color),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_project/utils/ui/custom_text.dart';

class InfoBoxChild extends StatelessWidget {
  final String heading;
  final String subHeading;

  const InfoBoxChild({
    Key? key,
    required this.heading,
    required this.subHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: heading,
          fontSize: 22,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w300,
        ),
        CustomText(
          text: subHeading,
          fontSize: 10,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

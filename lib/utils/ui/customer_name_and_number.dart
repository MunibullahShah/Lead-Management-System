import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/theme/app_colors.dart';
import 'custom_text.dart';

class CustomerNameAndNumber extends StatelessWidget {
  final String name;
  final String number;

  const CustomerNameAndNumber({
    Key? key,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: 'Name',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors().grey,
            ),
            const Spacer(),
            CustomText(
              text: name,
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          children: [
            CustomText(
              text: 'Number',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors().grey,
            ),
            const Spacer(),
            CustomText(
              text: number,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ],
    );
  }
}

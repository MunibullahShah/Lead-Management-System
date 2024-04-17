import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../utils/ui/custom_text.dart';
import '../../../utils/ui/customer_name_and_number.dart';

class CampaignInfo extends StatelessWidget {
  final String name;
  final String number;
  final String note;

  const CampaignInfo({
    Key? key,
    required this.name,
    required this.number,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
      child: SizedBox(
        height: 76.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.sp,
              ),
              _headingText(
                text: 'Customer Info',
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              _divider(),
              SizedBox(
                height: 22.sp,
              ),
              CustomerNameAndNumber(
                name: name,
                number: number,
              ),
              SizedBox(
                height: 22.sp,
              ),
              _greyDivider(),
              SizedBox(
                height: 18.sp,
              ),
              _headingText(
                text: 'Notes',
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              _divider(),
              SizedBox(
                height: 18.sp,
              ),
              _noteText(),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingText({required String text, color}) => CustomText(
        text: text,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
      );

  Widget _divider() => SizedBox(
        width: 13.w,
        child: Divider(
          color: AppColors().secondary,
          thickness: 2,
        ),
      );

  Widget _greyDivider() => Divider(
        thickness: .5,
        color: AppColors().lightGrey,
      );

  Widget _noteText() => CustomText(
        text: note,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors().greyText,
      );
}

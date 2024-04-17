import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/config.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/utils/ui/buttons/primary_button.dart';
import 'package:lms_project/utils/ui/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomDialog extends StatelessWidget {
  String title;
  String message;
  VoidCallback onConfirm;
  CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                  vertical: pageVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: message,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    PrimaryButton(
                      text: 'Yes',
                      onTap: onConfirm ,
                      color: AppColors().red,
                    ),
                    PrimaryButton(
                      text: "No",
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}

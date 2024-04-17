import 'package:flutter/material.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/utils/ui/buttons/primary_button.dart';
import 'package:lms_project/utils/ui/ui.dart';
import 'package:sizer/sizer.dart';

import '../../constants/asset_paths.dart';

class ErrorPageWithRetry extends StatelessWidget {
  VoidCallback? onTap;
  ErrorPageWithRetry({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SizedBox(
      height: 70.h,
      width: 95.w,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isDarkMode ? errorDarkImage : errorImage,
                width: 120.sp,
                height: 120.sp,
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomText(
                text: 'No Notifications yet!',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: 'We’ll notify you once we have\nsomething for you.',
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              PrimaryButton(
                text: 'Retry',
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

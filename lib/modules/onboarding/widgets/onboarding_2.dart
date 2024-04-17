import 'package:flutter/material.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/ui.dart';

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
      child: Column(
        children: [
          SizedBox(
            height: onBoardingTopPadding,
          ),
          SizedBox(
            height: 5.h,
          ),
          const OnBoarding2Image(),
          SizedBox(
            height: 3.h,
          ),
          CustomText(
            text:
                'The performance marketing agency\nthat unlocks your potential with creative',
            textAlign: TextAlign.center,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 2.h,
          ),
          // CustomText(
          //   text: ' Aenean commodo sit amet\nest eu porta',
          //   textAlign: TextAlign.center,
          //   fontSize: 15,
          //   color: Theme.of(context).colorScheme.onPrimary,
          //   fontWeight: FontWeight.w400,
          // ),
        ],
      ),
    );
  }
}

class OnBoarding2Image extends StatelessWidget {
  const OnBoarding2Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      width: 170.sp,
      height: 170.sp,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(isDarkMode ? onBoarding2Dark : onBoarding2),
            fit: BoxFit.contain),
      ),
    );
  }
}

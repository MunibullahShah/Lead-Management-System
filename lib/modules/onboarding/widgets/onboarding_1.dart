import 'package:flutter/material.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/ui.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({Key? key}) : super(key: key);

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
          const OnBoarding1Image(),
          SizedBox(
            height: 3.h,
          ),
          CustomText(
            text:
                'Transform your brand with\nrevolutionary digital experiences',
            textAlign: TextAlign.center,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          SizedBox(
            height: 2.h,
          ),
          // CustomText(
          //   text: 'Maecenas pharetra quis\nnunc sed aliquam',
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

class OnBoarding1Image extends StatelessWidget {
  const OnBoarding1Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      width: 170.sp,
      height: 170.sp,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(isDarkMode ? onBoarding1Dark : onBoarding1),
            fit: BoxFit.contain),
      ),
    );
  }
}

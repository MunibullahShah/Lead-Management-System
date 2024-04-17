import 'package:flutter/material.dart';
import 'package:lms_project/config/config.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/buttons/secondary_button.dart';
import '../../../utils/ui/ui.dart';

class OnBoardingPage3 extends StatelessWidget {
  final Function onDone;

  const OnBoardingPage3({
    Key? key,
    required this.onDone,
  }) : super(key: key);

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
          const OnBoarding3Image(),
          SizedBox(
            height: 3.h,
          ),
          CustomText(
            text:
                'Global leadership teams trust Modern to deliver marketing-led business solutions\nthat define and realise bold ambitions',
            textAlign: TextAlign.center,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 2.h,
          ),
          // CustomText(
          //   text: 'Sed consectetur ultriciesnunc,\nnon sodales mi gravida sed',
          //   textAlign: TextAlign.center,
          //   color: Theme.of(context).colorScheme.onPrimary,
          //   fontSize: 15,
          //   fontWeight: FontWeight.w400,
          // ),
          const Spacer(),
          SecondaryButton(
            onTap: () {
              onDone.call();
            },
            child: CustomText(
              text: 'Log In',
              fontSize: 13,
              color: AppColors().secondary,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}

class OnBoarding3Image extends StatelessWidget {
  const OnBoarding3Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      width: 170.sp,
      height: 170.sp,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(isDarkMode ? onBoarding3Dark : onBoarding3),
            fit: BoxFit.contain),
      ),
    );
  }
}

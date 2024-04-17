import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/config.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/ui/no_internet_page.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/appbar/statusbar.dart';
import '../../../utils/ui/custom_text.dart';
import '../../login/view/login_view.dart';
import '../controller/onBoarding_controller.dart';
import '../widgets/onBoarding_3.dart';
import '../widgets/onboarding_1.dart';
import '../widgets/onboarding_2.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({Key? key}) : super(key: key);

  final OnBoardingController _controller = Get.put(OnBoardingController());
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, position) {
                return _onBoardingViews(position: position);
              },
              onPageChanged: (position) {
                _controller.updatePageIndex(position: position);
              },
            ),
            _pageViewIndicator(context: context),
            _skipText(onSkip: _onSkip),
          ],
        ),
      ),
    );
  }

  void _onSkip() {
    Get.offAll(
      () => Controller.isConnected.value
          ? LoginView()
          : NoInternetPage(onTryAgain: () {
              _onSkip();
            }),
    );
  }

  Widget _skipText({required Function onSkip}) {
    return Obx(() => Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: onBoardingTopPadding,
              right: 8.w,
            ),
            child: InkWell(
              onTap: () {
                onSkip.call();
              },
              child: SizedBox(
                width: 70,
                height: 30,
                child: Center(
                  child: CustomText(
                      text: _controller.skipText.value, fontSize: 14),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _pageViewIndicator({required BuildContext context}) {
    return Obx(
      () => Positioned(
        left: 0,
        right: 0,
        bottom: 80.sp,
        child: DotsIndicator(
          dotsCount: 3,
          position: _controller.pageIndex.value,
          decorator: DotsDecorator(
            color: Theme.of(context).unselectedWidgetColor,
            activeColor: AppColors().secondary,
            size: Size.square(5.sp),
            activeSize: Size(20.sp, 5.sp),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
    );
  }

  Widget _onBoardingViews({required int position}) {
    switch (position) {
      case 0:
        return const OnBoardingPage1();
      case 1:
        return const OnBoardingPage2();
      case 2:
        return OnBoardingPage3(
          onDone: () {
            Get.offAll(() => LoginView());
          },
        );
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}

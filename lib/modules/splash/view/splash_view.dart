import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/splash/controller/splash_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../utils/ui/appbar/statusbar.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final SplashController _controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Image.asset(
            splashLogo,
            width: 20.h,
            height: 20.h,
          ),
        ),
      ),
    );
  }
}

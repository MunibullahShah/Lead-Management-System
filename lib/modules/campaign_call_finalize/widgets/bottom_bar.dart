import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/ui/buttons/primary_button.dart';

class CampaignBottomBar extends StatelessWidget {
  final Function onWhatsappTap;
  final Function onMessageTap;
  final Function onAddContactTap;
  final VoidCallback onNextTap;
  bool isDisabled;
  final String buttonTitle;
  var buttonTitleColor;

  CampaignBottomBar({
    Key? key,
    required this.onWhatsappTap,
    required this.onMessageTap,
    required this.onAddContactTap,
    this.isDisabled = true,
    required this.onNextTap,
    required this.buttonTitle,
    this.buttonTitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 60.sp,
      padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          isDarkMode
              ? BoxShadow(
                  color: AppColors().grey,
                  blurRadius: 2.sp,
                  offset: Offset(0, 2.sp),
                )
              : BoxShadow(
                  color: AppColors().finalizedButtonsShadowColor,
                  blurRadius: 15.sp,
                  offset: Offset(0, 2.sp),
                ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomBarButton(
            color: AppColors().bottomBarWhatsapp,
            image: whatsappIcon,
            onTap: () {
              onWhatsappTap.call();
            },
          ),
          _bottomBarButton(
            color: AppColors().bottomBarMessage,
            image: messageIcon,
            onTap: () {
              onMessageTap.call();
            },
          ),
          _bottomBarButton(
            color: AppColors().bottomBarAddContact,
            image: contactIcon,
            onTap: () {
              onAddContactTap.call();
            },
          ),
          PrimaryButton(
            color: buttonTitleColor,
            width: 35.w,
            text: buttonTitle,
            onTap: isDisabled ? null : onNextTap,
          ),
        ],
      ),
    );
  }

  Widget _bottomBarButton({
    required Color color,
    required String image,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: 40.sp,
        height: 40.sp,
        padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          image,
          // width: 5.h,
          // height: 5.h,
        ),
      ),
    );
  }
}

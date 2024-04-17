import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';

class TopBox extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const TopBox({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: child,
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(
            right: 3.8.h,
            top: 46.sp,
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onTap.call();
            },
            child: Image.asset(
              isDarkMode ? pauseCampaignDark : pauseCampaign,
              width: 50.sp,
              height: 50.sp,
            ),
          ),
        ),
      ],
    );
  }
}

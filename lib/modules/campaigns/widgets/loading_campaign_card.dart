import 'package:flutter/material.dart';
import 'package:lms_project/config/config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';
import '../../../utils/ui/grey_box_for_shimmer.dart';

class LoadingCampaignCard extends StatelessWidget {
  const LoadingCampaignCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors().solidShimmerColor,
      highlightColor: AppColors().shimmerColor,
      child: Container(
        width: double.infinity,
        height: 21.5.h,
        padding: EdgeInsets.symmetric(
          vertical: 10.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 1,
            color: AppColors().inputBorderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              child: GreyBox(
                width: 200,
                height: 15,
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              child: const GreyBox(height: 5),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GreyBox(width: 70, height: 10),
                      SizedBox(height: 1.h),
                      const GreyBox(width: 50, height: 18),
                    ],
                  ),
                  const Spacer(),
                  _greyCircle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _greyCircle() {
    return ClipOval(
      child: Container(
        width: 38.sp,
        height: 38.sp,
        color: Colors.grey,
      ),
    );
  }
}

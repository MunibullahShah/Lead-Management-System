import 'package:flutter/material.dart';
import 'package:lms_project/config/theme/app_colors.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/grey_box_for_shimmer.dart';

class LoadingTaskCard extends StatelessWidget {
  const LoadingTaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 18.h,
      padding: EdgeInsets.symmetric(
        horizontal: pageHorizontalPadding,
        vertical: pageVerticalPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: 1,
          color: AppColors().inputBorderColor,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: AppColors().solidShimmerColor,
                  highlightColor: AppColors().shimmerColor,
                  child: const GreyBox(
                    width: 200,
                    height: 15,
                  )),
              SizedBox(
                height: 10.sp,
              ),
              Shimmer.fromColors(
                  baseColor: AppColors().solidShimmerColor,
                  highlightColor: AppColors().shimmerColor,
                  child: const GreyBox(width: 80, height: 10)),
              SizedBox(
                height: 10.sp,
              ),
              Shimmer.fromColors(
                  baseColor: AppColors().solidShimmerColor,
                  highlightColor: AppColors().shimmerColor,
                  child: const GreyBox(width: 150, height: 10)),
            ],
          ),
          Positioned(
            right: 10.sp,
            bottom: -33.sp,
            child: Shimmer.fromColors(
              baseColor: AppColors().solidShimmerColor,
              highlightColor: AppColors().shimmerColor,
              child: _greyCircle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _greyCircle() {
    return ClipOval(
      child: Container(
        width: 50.sp,
        height: 50.sp,
        color: Colors.grey,
      ),
    );
  }
}

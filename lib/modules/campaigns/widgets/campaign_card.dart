import 'package:flutter/material.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/utils/ui/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';

class CampaignCard extends StatelessWidget {
  CampaignModel campaignModel;

  CampaignCard({Key? key, required this.campaignModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20.h,
      padding: EdgeInsets.symmetric(
        vertical: 10.sp,
      ),
      decoration: BoxDecoration(
        color: campaignColorCombinationHelper(
            campaignModel.status ?? "", 'backgroundColor'),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: 1,
          color: campaignColorCombinationHelper(
              campaignModel.status ?? "", "borderColor"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
            child: CustomText(
              text: campaignModel.title ?? "N/A",
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimary,
              maxLines: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5.w),
            child: LinearPercentIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              progressColor: campaignColorCombinationHelper(
                  campaignModel.status ?? "", "indicatorColor"),
              percent: (campaignModel.completed ?? 1) /
                  (campaignModel.total == 0 ? 1 : campaignModel.total ?? 1),
              lineHeight: 5.sp,
              animation: true,
              animationDuration: 1000,
              barRadius: Radius.circular(50.sp),
            ),
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
                    CustomText(
                      text: 'Completed',
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text:
                          '${campaignModel.completed ?? 0}/${campaignModel.total ?? 0}',
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  campaignColorCombinationHelper(
                      campaignModel.status ?? "", "image"),
                  width: 38.sp,
                  height: 38.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

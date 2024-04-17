import 'package:flutter/material.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:sizer/sizer.dart';

import 'loading_campaign_card.dart';

class LoadingCampaignsList extends StatelessWidget {
  const LoadingCampaignsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      padding: EdgeInsets.symmetric(
        vertical: 10.sp,
        horizontal: pageHorizontalPadding,
      ),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.sp,
        );
      },
      itemBuilder: (context, index) {
        return const LoadingCampaignCard();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaign_detail/controller/campaign_detail_controller.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/appbar/appBar.dart';
import 'package:lms_project/utils/ui/top_info_box.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/ui/appbar/statusbar.dart';
import '../../../utils/ui/top_box_child_text.dart';
import '../../../utils/ui/ui.dart';
import '../widgets/campaign_info.dart';

class CampaignDetailView extends StatelessWidget {
  CampaignDetailView({
    Key? key,
  }) : super(key: key);

  final CampaignDetailController controller = Get.put(
    CampaignDetailController(),
  );

  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return WillPopScope(
      onWillPop: () async {
        controller.goBack();
        return false;
      },
      child: Scaffold(
        floatingActionButton: InkWell(
          customBorder: const CircleBorder(),
          onTap: () async {
            if (!(controller.campaignDetailState.value.apiCallState ==
                APICallState.failure)) {
              await controller.callNumber(
                  controller.campaignModel.campaignDetailModel.number ?? "N/A",
                  controller.campaignModel.campaignDetailModel.id ?? 0,
                  "campaign");
            }
          },
          child: Image.asset(
            callButton,
            width: 50.sp,
            height: 50.sp,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              leadingIcon: const AppBarBackIcon(),
              title: 'Call Now',
              color: Theme.of(context).colorScheme.secondaryContainer,
              titleColor: Theme.of(context).colorScheme.onPrimary,
              onTap: (context) {
                controller.goBack();
              },
              child: TopInfoBox(
                color: AppColors().secondaryLight,
                child: TopBoxChildText(
                  text: controller.campaignModel.title ?? "N/A",
                  textColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Obx(
              () => APIStateWidget(
                successWidget: CampaignInfo(
                  name:
                      controller.campaignDetailState.value.model?.name ?? "N/A",
                  number: controller.campaignDetailState.value.model?.number ??
                      "N/A",
                  note: controller.campaignDetailState.value.model?.note ??
                      "note",
                ),
                generalApiState: controller.campaignDetailState.value,
                loadingWidget: Expanded(
                  child: Center(
                    child: Lottie.asset(
                      loader,
                      width: 20.h,
                      height: 20.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

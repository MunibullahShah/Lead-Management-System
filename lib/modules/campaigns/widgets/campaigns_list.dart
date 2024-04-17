import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/modules/campaigns/controller/campaigns_controller.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/modules/campaigns/widgets/loading_campaigns_list.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/error_page_with_retry.dart';

import 'campaign_card.dart';

class CampaignsList extends StatelessWidget {
  CampaignsList({
    Key? key,
  }) : super(key: key);

  final CampaignsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => APIStateWidget(
          loadingWidget: const LoadingCampaignsList(),
          successWidget: RefreshIndicator(
            color: Theme.of(context).colorScheme.onPrimary,
            onRefresh: () async {
              await controller.getCampaigns();
            },
            child: ListView.separated(
              itemCount:
                  controller.campaignState.value.model?.campaign?.length ?? 0,
              padding: EdgeInsets.symmetric(
                vertical: pageHorizontalPadding,
                horizontal: pageHorizontalPadding,
              ),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: pageHorizontalPadding,
                );
              },
              itemBuilder: (context, index) {
                return InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    controller.goToCampaign(index);
                  },
                  child: CampaignCard(
                    campaignModel: controller
                            .campaignState.value.model?.campaign
                            ?.elementAt(index) ??
                        CampaignModel(),
                  ),
                );
              },
            ),
          ),
          failureWidget: ErrorPageWithRetry(
            onTap: () {
              controller.getCampaigns();
            },
          ),
          generalApiState: controller.campaignState.value,
        ),
      ),
    );
  }
}

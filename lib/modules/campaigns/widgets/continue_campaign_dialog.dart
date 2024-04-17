import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/constants/asset_paths.dart';
import 'package:lms_project/modules/campaigns/controller/continue_dialog_controller.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/utils/ui/buttons/primary_button.dart';
import 'package:lms_project/utils/ui/custom_text.dart';
import 'package:sizer/sizer.dart';

class ContinueCampaignDialog extends StatelessWidget {
  ContinueCampaignDialog({Key? key, required this.campaignModel})
      : super(key: key);

  CampaignModel campaignModel;
  final ContinueDialogController controller =
      Get.put(ContinueDialogController());

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                  vertical: pageVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: campaignModel.title ?? "N/A",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: 'Do you want to continue this campaign?',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    PrimaryButton(
                      text: 'Continue',
                      onTap: () async {
                        controller.continueCampaign(campaignModel, context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                dialogExitButtonImage,
                width: 35.sp,
                height: 35.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

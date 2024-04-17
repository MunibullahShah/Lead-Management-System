import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/theme/app_colors.dart';
import 'package:lms_project/modules/campaign_detail/view/campaign_detail_view.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class ContinueDialogController extends GetxController {
  Future<void> continueCampaign(CampaignModel campaignModel, context) async {
    Get.dialog(
      Loader(),
      barrierDismissible: false,
    );
    try {
      await BackendRepository()
          .pauseCampaign(campaignId: campaignModel.id ?? 0, status: "ongoing")
          .then((value) {
        if (value["code"] == 200) {
          Get.off(() => CampaignDetailView(), arguments: campaignModel);
        } else {
          Get.back();
          getErrorSnackbar(
              title: "Error",
              message: "Error occurred while continuing campaign");
        }
      });
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Something went wrong. Please try again later",
          ),
          backgroundColor: AppColors().red,
        ),
      );
    }
  }
}

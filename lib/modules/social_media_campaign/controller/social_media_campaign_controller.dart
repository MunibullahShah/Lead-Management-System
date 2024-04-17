import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/modules/campaign_detail/view/campaign_detail_view.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/modules/campaigns/widgets/continue_campaign_dialog.dart';
import 'package:lms_project/modules/social_media_campaign/repository/repository.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/network/general_api_state.dart';
import 'package:lms_project/utils/services/local_notification_service.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class SocialMediaCampaignController extends Controller {
  Rx<GeneralApiState<CampaignListModel>> campaignState =
      const GeneralApiState<CampaignListModel>(
    apiCallState: APICallState.loading,
  ).obs;

  @override
  void onInit() async {
    super.onInit();
    currentController = CurrentController.campaign;
    getCampaigns();
    listenToCampaignNotifications();
  }

  Future<void> getCampaigns() async {
    campaignState.value = const GeneralApiState<CampaignListModel>(
        apiCallState: APICallState.loading);

    try {
      await SocialMediaCampaignRepository().fetchCampaigns().then((value) {
        if (value.campaign!.isEmpty) {
          campaignState.value = const GeneralApiState<CampaignListModel>(
            apiCallState: APICallState.failure,
          );
        } else {
          campaignState.value = GeneralApiState<CampaignListModel>(
            apiCallState: APICallState.loaded,
            model: value,
          );
        }
      });
    } catch (e) {
      campaignState.value = GeneralApiState<CampaignListModel>(
          apiCallState: APICallState.failure, errorMessage: e.toString());
    }
  }

  void goToCampaign(int index) {
    if (campaignState.value.model?.campaign?.elementAt(index).status ==
        "ongoing") {
      Get.to(() => CampaignDetailView(),
          arguments: campaignState.value.model?.campaign?.elementAt(index));
    } else if (campaignState.value.model?.campaign?.elementAt(index).status ==
            "new" ||
        campaignState.value.model?.campaign?.elementAt(index).status ==
            "onhold") {
      Get.dialog(
          ContinueCampaignDialog(
            campaignModel:
                campaignState.value.model?.campaign?.elementAt(index) ??
                    CampaignModel(),
          ),
          barrierDismissible: false);
    } else {
      getErrorSnackbar(title: "Error", message: "This campaign cannot be open");
    }
  }

  void listenToCampaignNotifications() {
    // 2. This method only call when App in forGround
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification androidNotification = message.notification!.android!;

      if (currentController == CurrentController.campaign) {
        getCampaigns();
        LocalNotificationService().createAndDisplayNotification(message);
      }
    });
  }

  @override
  void dispose() {
    currentController = CurrentController.other;
    super.dispose();
  }
}

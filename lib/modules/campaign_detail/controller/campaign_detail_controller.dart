import 'package:get/get.dart';
import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';
import 'package:lms_project/modules/campaign_detail/repository/repository.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/modules/campaigns/view/campaigns_view.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/network/general_api_state.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class CampaignDetailController extends Controller {
  late CampaignModel campaignModel;

  Rx<GeneralApiState<CampaignDetailModel>> campaignDetailState =
      const GeneralApiState<CampaignDetailModel>(
    apiCallState: APICallState.loading,
  ).obs;

  final CampaignDetailRepository campaignRepository =
      CampaignDetailRepository();

  @override
  void onInit() {
    campaignModel = Get.arguments;
    getCampaignDetail();
    setStream();
    super.onInit();
  }

  Future<void> getCampaignDetail() async {
    campaignDetailState.value = const GeneralApiState<CampaignDetailModel>(
        apiCallState: APICallState.loading);
    try {
      String? token = await LocalStorageService().getToken();
      await campaignRepository
          .fetchCampaignDetail(
        id: campaignModel.id ?? 0,
        token: token ?? "",
      )
          .then((value) {
        if (value.id == 0 || value.id == null) {
          Get.offAll(() => CampaignsView());
          getSuccessSnackbar(title: "", message: "Campaign numbers completed.");
          return;
        }
        campaignDetailState.value = GeneralApiState<CampaignDetailModel>(
          apiCallState: APICallState.loaded,
          model: value,
        );
        if (campaignDetailState.value.model?.status != "ongoing") {
          Get.offAll(() => CampaignsView());
          getErrorSnackbar(title: "", message: "Campaign is paused by admin.");
        }
        campaignModel.campaignDetailModel = value;
      });
    } catch (e) {
      campaignDetailState.value = GeneralApiState<CampaignDetailModel>(
        apiCallState: APICallState.failure,
        errorMessage: e.toString(),
      );
    }
  }

  void goBack() async {
    await Get.offAll(() => CampaignsView());
  }
}

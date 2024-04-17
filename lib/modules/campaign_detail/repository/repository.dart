import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class CampaignDetailRepository {
  Future<CampaignDetailModel> fetchCampaignDetail(
      {required int id, required String token}) async {
    String campaignResponse =
        await BackendRepository().fetchCampaignDetail(id: id);
    if (campaignResponse == "location") {
      getErrorSnackbar(title: "Location", message: "Enable location services");
      await Future.delayed(Duration(seconds: 1),
          () async => await Geolocator.openLocationSettings());
    }
    var json = jsonDecode(campaignResponse);
    return CampaignDetailModel.fromJson(json);
  }

  Future<void> updateAgentOnCallStatus({required int status}) async {
    String response =
        await BackendRepository().updateAgentOnCallStatus(status: status);
  }
}

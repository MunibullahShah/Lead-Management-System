import 'dart:convert';

import 'package:lms_project/utils/network/backend_repository.dart';

import '../model/campaigns_model.dart';

class CampaignsRepository {
  Future<CampaignListModel> fetchCampaigns() async {
    String campaignsResponse = await BackendRepository().fetchCampaigns();
    var json = jsonDecode(campaignsResponse);
    return CampaignListModel.fromJson(json);
  }
}

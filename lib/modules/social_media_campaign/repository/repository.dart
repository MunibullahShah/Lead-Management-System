import 'dart:convert';

import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';

class SocialMediaCampaignRepository {
  Future<CampaignListModel> fetchCampaigns() async {
    String campaignsResponse = await BackendRepository().fetchCampaigns();
    var json = jsonDecode(campaignsResponse);
    return CampaignListModel.fromJson(json);
  }
}

import 'package:lms_project/modules/campaign_call_finalize/models/campaign_call_finalize_model.dart';
import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';

class CampaignListModel {
  List<CampaignModel>? campaign;

  CampaignListModel({this.campaign});

  CampaignListModel.fromJson(Map<String, dynamic> json) {
    if (json['campaigns'] != null) {
      campaign = <CampaignModel>[];
      json['campaigns'].forEach((v) {
        campaign!.add(CampaignModel.fromJson(v));
      });
    }
  }
}

class CampaignModel {
  int? id;
  String? title;
  String? status;
  int? completed;
  int? total;
  CampaignDetailModel campaignDetailModel = CampaignDetailModel();
  CampaignCallFinalizeModel finalizeModel = CampaignCallFinalizeModel();

  CampaignModel({this.id, this.title, this.status, this.completed, this.total});

  CampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['campaign_id'] ?? -1;
    title = json['title'] ?? "N/A";
    status = json['status'] ?? "N/A";
    completed = json['completed'] ?? 0;
    total = json['total'] ?? 1;
  }
}

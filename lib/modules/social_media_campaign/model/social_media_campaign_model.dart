// import 'package:lms_project/modules/campaign_call_finalize/models/campaign_call_finalize_model.dart';
// import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';
//
// class SocialMediaListCampaignModel {
//   List<SocialMediaCampaignModel>? campaign;
//
//   SocialMediaListCampaignModel({this.campaign});
//
//   SocialMediaListCampaignModel.fromJson(Map<String, dynamic> json) {
//     if (json['campaigns'] != null) {
//       campaign = <SocialMediaCampaignModel>[];
//       json['campaigns'].forEach((v) {
//         campaign!.add(SocialMediaCampaignModel.fromJson(v));
//       });
//     }
//   }
// }
//
// class SocialMediaCampaignModel {
//   int? id;
//   String? title;
//   String? status;
//   int? completed;
//   int? total;
//   CampaignDetailModel campaignDetailModel = CampaignDetailModel();
//   CampaignCallFinalizeModel finalizeModel = CampaignCallFinalizeModel();
//
//   SocialMediaCampaignModel(
//       {this.id, this.title, this.status, this.completed, this.total});
//
//   SocialMediaCampaignModel.fromJson(Map<String, dynamic> json) {
//     id = json['campaign_id'] ?? -1;
//     title = json['title'] ?? "N/A";
//     status = json['status'] ?? "N/A";
//     completed = json['completed'] ?? 0;
//     total = json['total'] ?? 1;
//   }
// }

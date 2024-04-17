class CampaignCallFinalizeModel {
  int? campaignId;
  int? campaignDetailId;
  int? taskId;

  String? campaignTitle;

  String? customerName;
  String? customerNumber;

  String? callOutcome;
  String? leadStatus;
  String? taskDescription;
  String? dateTime;
  String? notes;

  Map<String, dynamic> campaignToJson() {
    final Map<String, dynamic> data = {};
    data["campaign_number_id"] = campaignDetailId;
    data["call_status"] = callOutcome;
    data["lead_status"] = leadStatus;
    data["task_description"] = taskDescription;
    data["task_date_time"] = dateTime;
    data["note"] = notes;
    return data;
  }
}

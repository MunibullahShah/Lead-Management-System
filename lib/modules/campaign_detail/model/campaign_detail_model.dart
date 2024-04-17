int? campaignDetailId;

class CampaignDetailModel {
  int? id;
  String? name;
  String? number;
  String? note;
  String? status;

  CampaignDetailModel({
    this.id,
    this.name,
    this.number,
    this.note,
    this.status,
  });

  CampaignDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['campaign_number_id'];
    name = json['name'];
    number = json['number'];
    note = json['note'];
    status = json['status'] ?? "ongoing";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['note'] = this.note;
    data['status'] = this.status;
    return data;
  }
}

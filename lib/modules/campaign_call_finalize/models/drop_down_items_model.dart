class DropDownItems {
  List<String> callOutcomeItems = [];

  List<String> callOutcomeDisplayItems = [];

  List<String> leadStatusItems = [];

  List<String> leadStatusDisplayItems = [];

  List<String> taskDescriptionItems = [];

  List<String> taskDescriptionDisplayItems = [];

  fromJson(Map<String, dynamic> json, String status) {
    if (json['statuses'] != null) {
      switch (status) {
        case "call_status":
          json['statuses'].forEach((v) {
            callOutcomeDisplayItems.add(
              v['display_name'] ?? "N/A",
            );
            callOutcomeItems.add(v["name"]);
          });
          break;
        case "lead_status":
          json['statuses'].forEach((v) {
            leadStatusDisplayItems.add(
              v['display_name'] ?? "N/A",
            );
            leadStatusItems.add(
              v['name'] ?? "N/A",
            );
          });
          break;
        case "task_description":
          json['statuses'].forEach((v) {
            taskDescriptionDisplayItems.add(
              v['display_name'] ?? "N/A",
            );
            taskDescriptionItems.add(
              v['name'] ?? "N/A",
            );
          });
          break;
      }
    } else {
      callOutcomeDisplayItems.add("N/A");
      leadStatusDisplayItems.add("N/A");
      taskDescriptionDisplayItems.add("N/A");
    }
  }
}

class CallStatus {
  List<Statuses>? statuses;

  CallStatus({this.statuses});

  CallStatus.fromJson(Map<String, dynamic> json) {
    if (json['statuses'] != null) {
      statuses = <Statuses>[];
      json['statuses'].forEach((v) {
        statuses!.add(new Statuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statuses != null) {
      data['statuses'] = this.statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statuses {
  String? name;
  String? displayName;

  Statuses({this.name, this.displayName});

  Statuses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    return data;
  }
}

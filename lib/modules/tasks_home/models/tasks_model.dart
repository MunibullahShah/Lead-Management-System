import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/extensions.dart';

class TasksModel {
  bool tabDot = false;
  List<SingleTask>? tasks;

  TasksModel({this.tasks});

  TasksModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <SingleTask>[];
      json['tasks'].forEach((v) {
        tasks!.add(SingleTask.fromJson(v));
        if (v['opened'] == 0) {
          tabDot = true;
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleTask {
  int? id = 0;
  String? title = "N/A";
  String? subTitle = "N/A";
  String? dateTime = "N/A";
  int? campaignNoId = 0;
  TaskState? taskState;
  bool? hasOpened = true;
  String? name = "N/A";
  String? number = "N/A";
  String? note = "N/A";
  List<Timeline>? timeline = [];

  SingleTask(
      {this.id,
      this.title,
      this.subTitle,
      this.dateTime,
      this.campaignNoId,
      this.taskState,
      this.hasOpened,
      this.name,
      this.number,
      this.note,
      this.timeline});

  SingleTask.fromJson(Map<String, dynamic> json) {
    id = json['task_id'] ?? 0;
    campaignNoId = json["campaign_number_id"] ?? 0;
    title = json['campaign_title'] ?? "N/A";
    subTitle = json['campaign_sub_title'] ?? "N/A";
    dateTime = dateTImeConversion(json['task_date_time']) ?? "N/A";
    taskState = assignState(json['type']) ?? TaskState.overdue;
    hasOpened =
        json['opened'] != null ? (json['opened'] == 0 ? false : true) : false;
    name = json['person_name'] ?? "N/A";
    number = json['msisdn'] ?? "N/A";
    note = json['agent_note'] ?? "N/A";
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(Timeline.fromJson(v));
      });
    } else
      timeline = [
        Timeline(),
      ];
  }

  TaskState? assignState(json) {
    return states[json];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['dateTime'] = dateTime;
    data['taskState'] = taskState;
    data['hasOpened'] = hasOpened;
    data['name'] = name;
    data['number'] = number;
    data['note'] = note;
    if (timeline != null) {
      data['timeline'] = timeline!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String? dateTImeConversion(String dateTime) {
    DateTime date = DateTime(
      int.parse(dateTime.substring(0, 4)),
      int.parse(dateTime.substring(5, 7)),
      int.parse(dateTime.substring(8, 10)),
      int.parse(dateTime.substring(11, 13)),
      int.parse(dateTime.substring(14, 16)),
    );
    DateTime? time = DateTime.tryParse(dateTime.substring(11));
    String formattedDateTime =
        "${date.toFormattedDateTimeString()} ${formattedTime(date)}";
    return formattedDateTime;
  }
}

class Timeline {
  String? callMode = "N/A";
  String? callOutCome = "N/A";
  String? leadStatus = "N/A";
  String? agentNotes = "N/A";
  String? taskCreated = "N/A";
  String? description = "N/A";

  Timeline(
      {this.callMode,
      this.callOutCome,
      this.leadStatus,
      this.agentNotes,
      this.taskCreated,
      this.description});

  Timeline.fromJson(Map<String, dynamic> json) {
    callMode = json['callMode'] ?? "N/A";
    callOutCome = json['call_status'] ?? "N/A";
    leadStatus = json['lead_status'] ?? "N/A";
    agentNotes = json['note'] ?? "N/A";
    taskCreated = json['created_at'] ?? "N/A";
    description = json['task_description'] ?? "N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['callMode'] = callMode;
    data['callOutCome'] = callOutCome;
    data['leadStatus'] = leadStatus;
    data['agentNotes'] = agentNotes;
    data['taskCreated'] = taskCreated;
    data['description'] = description;
    return data;
  }
}

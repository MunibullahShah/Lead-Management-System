import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class TaskDetailRepository {
  Future<SingleTask> fetchTimeline({required SingleTask task}) async {
    try {
      var response = await BackendRepository().getTimeline(
        campaignNoId: task.campaignNoId.toString(),
      );
      if (response == "location") {
        getErrorSnackbar(
            title: "Location", message: "Enable location services");
        await Future.delayed(Duration(seconds: 1),
            () async => await Geolocator.openLocationSettings());
        task.timeline = [];
      }
      var json = jsonDecode(response);
      if (json["response"]['timeline'] != null) {
        task.timeline = [];
        json["response"]['timeline'].forEach((v) {
          task.timeline!.add(Timeline.fromJson(v));
        });
      } else {
        task.timeline = [];
      }
      return task;
    } catch (e) {
      task.timeline = [];
      return task;
    }
  }
}

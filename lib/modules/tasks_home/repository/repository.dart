import 'dart:convert';

import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';

class TasksRepository {
  Future<TasksModel> fetchTasks(String state, int campaignId) async {
    String response;
    if (campaignId == -1) {
      response = await BackendRepository().fetchTasks(
        state,
      );
    } else {
      response = await BackendRepository().fetchTasksOfCampaign(
        state,
        campaignId,
      );
    }

    var json = jsonDecode(response);
    var task = TasksModel.fromJson(json);
    return task;
  }
}

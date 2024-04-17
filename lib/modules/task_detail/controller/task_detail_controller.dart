import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/task_detail/repository/task_detail_repository.dart';
import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/modules/tasks_home/view/tasks_view.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/network/general_api_state.dart';

class TaskDetailController extends Controller {
  Rx<GeneralApiState<SingleTask>> timelineState =
      const GeneralApiState<SingleTask>(
    apiCallState: APICallState.loading,
  ).obs;

  late SingleTask task;

  @override
  void onInit() {
    task = Get.arguments;
    getTimeline(task);
    setStream();
    super.onInit();
  }

  void getTimeline(SingleTask task) async {
    try {
      task = await TaskDetailRepository().fetchTimeline(task: task);
      if (task.timeline?.length != 0) {
        timelineState.value = GeneralApiState<SingleTask>(
          model: task,
          apiCallState: APICallState.loaded,
        );
      } else {
        timelineState.value = const GeneralApiState<SingleTask>(
          apiCallState: APICallState.failure,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void goBack() async {
    await Get.offAll(() => TasksView());
  }
}

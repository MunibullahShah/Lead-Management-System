import 'package:get/get.dart';
import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/modules/tasks_home/repository/repository.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/network/general_api_state.dart';

class TasksController extends Controller {
  Rx<GeneralApiState<TasksModel>> allTasksState =
      const GeneralApiState<TasksModel>(
    apiCallState: APICallState.loading,
  ).obs;
  Rx<GeneralApiState<TasksModel>> upcomingTasksState =
      const GeneralApiState<TasksModel>(
    apiCallState: APICallState.loading,
  ).obs;
  Rx<GeneralApiState<TasksModel>> newTasksState =
      const GeneralApiState<TasksModel>(
    apiCallState: APICallState.loading,
  ).obs;
  Rx<GeneralApiState<TasksModel>> overdueTasksState =
      const GeneralApiState<TasksModel>(
    apiCallState: APICallState.loading,
  ).obs;

  RxBool allTaskTabDotController = false.obs;
  RxBool newTaskTabDotController = false.obs;
  RxBool overdueTaskTabDotController = false.obs;
  RxBool upcomingTaskTabDotController = false.obs;

  int? campaignId;

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      campaignId = args['campaign_id'];
    }
    getTasks(
      state: TaskState.all,
    );
    super.onInit();
  }

  Future<void> getTasks({required TaskState state}) async {
    allTasksState.value = const GeneralApiState<TasksModel>(
      apiCallState: APICallState.loading,
    );

    overdueTasksState.value = const GeneralApiState<TasksModel>(
      apiCallState: APICallState.loading,
    );

    newTasksState.value = const GeneralApiState<TasksModel>(
      apiCallState: APICallState.loading,
    );

    upcomingTasksState.value =
        const GeneralApiState<TasksModel>(apiCallState: APICallState.loading);

    switch (state) {
      case TaskState.all:
        try {
          TasksModel tasks = await TasksRepository().fetchTasks(
            state.name.toString(),
            campaignId ?? -1,
          );
          allTaskTabDotController.value = tasks.tabDot;
          allTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.loaded,
            model: tasks,
          );
          if (allTasksState.value.model == null) {
            allTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          } else {
            if (allTasksState.value.model?.tasks == null ||
                allTasksState.value.model!.tasks!.isEmpty) {
              allTasksState.value = const GeneralApiState<TasksModel>(
                apiCallState: APICallState.failure,
              );
            }
          }
        } catch (e) {
          allTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          );
        }
        break;

      case TaskState.overdue:
        try {
          TasksModel tasks = await TasksRepository().fetchTasks(
            state.name.toString(),
            campaignId ?? -1,
          );

          overdueTaskTabDotController.value = tasks.tabDot;
          overdueTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.loaded,
            model: tasks,
          );
          if (overdueTasksState.value.model == null) {
            overdueTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          } else if (overdueTasksState.value.model?.tasks == null ||
              overdueTasksState.value.model!.tasks!.isEmpty) {
            overdueTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          }
        } catch (e) {
          overdueTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          );
        }
        break;

      case TaskState.new_task:
        try {
          TasksModel value = await TasksRepository().fetchTasks(
            "new",
            campaignId ?? -1,
          );
          newTaskTabDotController.value = value.tabDot;
          newTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.loaded,
            model: value,
          );
          if (newTasksState.value.model == null) {
            newTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          } else if (newTasksState.value.model!.tasks!.isEmpty ||
              newTasksState.value.model?.tasks == null) {
            newTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          }
        } catch (e) {
          newTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          );
        }
        break;

      case TaskState.upcoming:
        try {
          TasksModel value = await TasksRepository().fetchTasks(
            state.name.toString(),
            campaignId ?? -1,
          );

          upcomingTaskTabDotController.value = value.tabDot;
          upcomingTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.loaded,
            model: value,
          );
          if (upcomingTasksState.value.model == null) {
            upcomingTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          } else if (upcomingTasksState.value.model!.tasks!.isEmpty ||
              upcomingTasksState.value.model?.tasks == null) {
            upcomingTasksState.value = const GeneralApiState<TasksModel>(
              apiCallState: APICallState.failure,
            );
          }
        } catch (e) {
          upcomingTasksState.value = GeneralApiState<TasksModel>(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          );
        }
        break;
    }
  }
}

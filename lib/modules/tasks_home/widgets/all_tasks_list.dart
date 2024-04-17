import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/modules/task_detail/view/task_detail_view.dart';
import 'package:lms_project/modules/tasks_home/controller/tasks_controller.dart';
import 'package:lms_project/modules/tasks_home/widgets/loading_tasks_list.dart';
import 'package:lms_project/modules/tasks_home/widgets/task_card.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/error_page_with_retry.dart';
import 'package:sizer/sizer.dart';

class AllTaskList extends StatelessWidget {
  final TasksController controller = Get.find();

  AllTaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => APIStateWidget(
        loadingWidget: const LoadingTasksList(),
        successWidget: RefreshIndicator(
          onRefresh: () async {
            await controller.getTasks(state: TaskState.all);
          },
          child: ListView.separated(
              padding: EdgeInsets.only(
                left: pageHorizontalPadding,
                right: pageHorizontalPadding,
                top: pageVerticalPadding,
                bottom: 5.h,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: () {
                    Get.to(
                      () => TaskDetailView(
                        taskState: controller.allTasksState.value.model?.tasks
                                ?.elementAt(index)
                                .taskState ??
                            TaskState.overdue,
                      ),
                      arguments: controller.allTasksState.value.model?.tasks
                          ?.elementAt(index),
                    );
                  },
                  child: TaskCard(
                    context: context,
                    heading: controller.allTasksState.value.model?.tasks
                            ?.elementAt(index)
                            .title ??
                        "",
                    subHeading: controller.allTasksState.value.model?.tasks
                            ?.elementAt(index)
                            .subTitle ??
                        "",
                    dateTime: controller.allTasksState.value.model?.tasks
                            ?.elementAt(index)
                            .dateTime ??
                        "",
                    taskState: controller.allTasksState.value.model?.tasks
                            ?.elementAt(index)
                            .taskState ??
                        TaskState.overdue,
                    hasOpened: controller.allTasksState.value.model?.tasks
                            ?.elementAt(index)
                            .hasOpened ??
                        false,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 30.sp,
                );
              },
              itemCount:
                  controller.allTasksState.value.model?.tasks?.length ?? 0),
        ),
        failureWidget: ErrorPageWithRetry(
          onTap: () {
            controller.getTasks(
              state: TaskState.all,
            );
          },
        ),
        generalApiState: controller.allTasksState.value));
  }
}

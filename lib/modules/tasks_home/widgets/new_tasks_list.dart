import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/tasks_home/controller/tasks_controller.dart';
import 'package:lms_project/modules/tasks_home/widgets/loading_tasks_list.dart';
import 'package:lms_project/modules/tasks_home/widgets/task_card.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/error_page_with_retry.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';
import '../../task_detail/view/task_detail_view.dart';

class NewTasksList extends StatelessWidget {
  final TasksController controller = Get.find();

  NewTasksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => APIStateWidget(
          loadingWidget: const LoadingTasksList(),
          successWidget: RefreshIndicator(
            onRefresh: () async {
              await controller.getTasks(state: TaskState.new_task);
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
                          taskState: controller.newTasksState.value.model!
                                  .tasks![index].taskState ??
                              TaskState.overdue,
                        ),
                        arguments:
                            controller.newTasksState.value.model!.tasks?[index],
                      );
                    },
                    child: TaskCard(
                      context: context,
                      heading: controller
                              .newTasksState.value.model!.tasks![index].title ??
                          "",
                      subHeading: controller.newTasksState.value.model!
                              .tasks![index].subTitle ??
                          "",
                      dateTime: controller.newTasksState.value.model!
                              .tasks![index].dateTime ??
                          "",
                      taskState: controller.newTasksState.value.model!
                              .tasks![index].taskState ??
                          TaskState.overdue,
                      hasOpened: controller.newTasksState.value.model!
                              .tasks![index].hasOpened ??
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
                    controller.newTasksState.value.model?.tasks?.length ?? 0),
          ),
          failureWidget: ErrorPageWithRetry(
            onTap: () {
              controller.getTasks(
                state: TaskState.new_task,
              );
            },
          ),
          generalApiState: controller.newTasksState.value),
    );
  }
}

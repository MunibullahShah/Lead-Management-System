import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/tasks_home/controller/tasks_controller.dart';
import 'package:lms_project/modules/tasks_home/widgets/all_tasks_list.dart';
import 'package:lms_project/modules/tasks_home/widgets/overdue_task_list.dart';
import 'package:lms_project/modules/tasks_home/widgets/upcoming_tasks_list.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/circle_badge.dart';
import 'package:lms_project/utils/ui/custom_dialog.dart';
import 'package:lms_project/utils/ui/drawer/custom_drawer.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:lms_project/utils/ui/ui.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../utils/ui/appbar/statusbar.dart';
import '../widgets/new_tasks_list.dart';

class TasksView extends StatelessWidget {
  TasksView({Key? key}) : super(key: key);

  final TasksController controller = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() async {
            if (!tabController.indexIsChanging) {
              await controller.getTasks(
                state: TaskState.values.elementAt(tabController.index),
              );
            }
          });
          return WillPopScope(
            onWillPop: () async {
              Get.dialog(
                CustomDialog(
                  title: 'Exit App',
                  message: 'Are you sure?',
                  onConfirm: () async {
                    Get.dialog(
                      Loader(),
                      barrierDismissible: false,
                    );
                    await BackendRepository().agentActiveStatus("0");
                    exit(0);
                  },
                ),
              );
              return false;
            },
            child: Scaffold(
              drawer: const CustomDrawer(),
              body: Column(
                children: [
                  MyAppBar(
                    leadingIcon: const AppBarMenuIcon(),
                    title: 'Task',
                    color: Theme.of(context).primaryColor,
                    onTap: (context) {
                      Scaffold.of(context).openDrawer();
                    },
                    height: 10.h,
                  ),
                  Obx(
                    () => TabBar(
                      indicator: _indicatorType(),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20.sp),
                      labelStyle: _labelStyle(),
                      unselectedLabelStyle: _unselectedLabelStyle(),
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.sp),
                      tabs: [
                        _tab(
                          title: 'All',
                          hasOpened: controller.allTaskTabDotController.value,
                        ),
                        _tab(
                            title: 'New',
                            hasOpened:
                                controller.newTaskTabDotController.value),
                        _tab(
                            title: 'Overdue',
                            hasOpened:
                                controller.overdueTaskTabDotController.value),
                        _tab(
                            title: 'Upcoming',
                            hasOpened:
                                controller.upcomingTaskTabDotController.value),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AllTaskList(),
                        NewTasksList(),
                        OverdueTasksList(),
                        UpcomingTasksList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tab({required String title, required bool hasOpened}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Tab(
          text: title,
        ),
        hasOpened == true
            ? Positioned(
                right: -5.sp,
                top: -.5.sp,
                child: CircleBadge(color: AppColors().orange),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600);

  TextStyle _unselectedLabelStyle() =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400);

  UnderlineTabIndicator _indicatorType() => UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors().secondary,
          width: 2.sp,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/modules/task_detail/controller/task_detail_controller.dart';
import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/top_box_child_text.dart';
import 'package:lms_project/utils/ui/top_info_box.dart';
import 'package:lms_project/utils/ui/ui.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/enums/enums.dart';
import '../../../utils/ui/appbar/statusbar.dart';
import '../../../utils/ui/customer_name_and_number.dart';

class TaskDetailView extends StatelessWidget {
  final TaskState taskState;

  TaskDetailController controller = Get.put(TaskDetailController());

  TaskDetailView({
    Key? key,
    required this.taskState,
  }) : super(key: key);

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    setStatusBarIconsColor(context: context);
    return WillPopScope(
      onWillPop: () async {
        controller.goBack();
        return false;
      },
      child: Scaffold(
        floatingActionButton: InkWell(
          customBorder: const CircleBorder(),
          onTap: () async {
            if (!(controller.timelineState.value.apiCallState ==
                APICallState.failure)) {
              await controller.callNumber(
                  controller.timelineState.value.model?.number ?? "0000",
                  controller.timelineState.value.model?.campaignNoId ?? 0,
                  "task");
            }
          },
          child: Image.asset(
            callButton,
            width: 50.sp,
            height: 50.sp,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              leadingIcon: AppBarBackIcon(
                color: isDarkMode
                    ? AppColors().primaryDark
                    : AppColors().appBarTextLightTheme,
              ),
              title: 'Task Detail',
              titleColor: isDarkMode
                  ? AppColors().primaryDark
                  : AppColors().appBarTextLightTheme,
              color: _getBgColor(),
              onTap: (context) {
                controller.goBack();
              },
              child: TopInfoBox(
                color: Colors.transparent,
                child: TopBoxChildText(
                  text: controller.task.title ?? "N/A",
                  textColor: isDarkMode
                      ? AppColors().primaryDark
                      : AppColors().appBarTextLightTheme,
                ),
              ),
            ),
            SizedBox(
              height: 77.h,
              child: Obx(
                () => APIStateWidget(
                  successWidget: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: pageHorizontalPadding,
                                    ),
                                    _headingText(
                                      text: 'Customer Info',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    _divider(),
                                    SizedBox(
                                      height: 22.sp,
                                    ),
                                    CustomerNameAndNumber(
                                      name: controller.timelineState.value.model
                                              ?.name ??
                                          "",
                                      number: controller.timelineState.value
                                              .model?.number ??
                                          "",
                                    ),
                                    SizedBox(
                                      height: 22.sp,
                                    ),
                                    _greyDivider(),
                                    SizedBox(
                                      height: 18.sp,
                                    ),
                                    _headingText(
                                      text: 'Notes',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    _divider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    _noteText(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    _greyDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    _headingText(
                                      text: 'Time Line',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    _divider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          controller.timelineState.value.model?.timeline
                                      ?.length ==
                                  0
                              ? Center(
                                  child: CustomText(
                                      text: "No timeline available",
                                      fontSize: 16),
                                )
                              : _timeLine(index, context),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      );
                    },
                    itemCount: controller
                                .timelineState.value.model?.timeline?.length ==
                            0
                        ? 1
                        : controller
                                .timelineState.value.model?.timeline?.length ??
                            1,
                  ),
                  generalApiState: controller.timelineState.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBgColor() {
    if (isDarkMode) {
      switch (taskState) {
        case TaskState.overdue:
          return AppColors().appBarRed;
        case TaskState.upcoming:
          return AppColors().appBarOrange;
        case TaskState.new_task:
          return AppColors().appBarBlue;
        default:
          return AppColors().primary;
      }
    } else {
      switch (taskState) {
        case TaskState.overdue:
          return AppColors().appBarRedLight;
        case TaskState.upcoming:
          return AppColors().appBarOrangeLight;
        case TaskState.new_task:
          return AppColors().appBarBlueLight;
        default:
          return AppColors().primaryDark;
      }
    }
  }

  Widget _timeLine(int index, context) {
    return SizedBox(
      height: 170.sp,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset(
                isDarkMode ? taskDetailCallDarkIcon : taskDetailCallIcon,
                width: 30.sp,
                height: 30.sp,
              ),
              Expanded(
                  // height: 15.h,
                  child: VerticalDivider(color: AppColors().secondary)),
              Image.asset(
                isDarkMode ? taskDetailMenuDarkIcon : taskDetailMenuIcon,
                width: 30.sp,
                height: 30.sp,
              ),
            ],
          ),
          SizedBox(
            width: 10.sp,
          ),
          _timeLineDetails(
              controller.timelineState.value.model?.timeline
                      ?.elementAt(index) ??
                  Timeline(),
              context),
          SizedBox(
            width: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _timeLineDetails(Timeline timeline, context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _detailRow(
                heading: 'Call Made',
                value: timeline.taskCreated!,
                context: context,
              ),
              SizedBox(
                height: 3.sp,
              ),
              _detailRow(
                heading: 'Call Outcome',
                value: timeline.callOutCome!,
                context: context,
              ),
              SizedBox(
                height: 3.sp,
              ),
              _detailRow(
                heading: 'Lead Status',
                value: timeline.leadStatus!,
                context: context,
              ),
              SizedBox(
                height: 3.sp,
              ),
              _detailRow(
                heading: 'Agent Notes',
                value: timeline.agentNotes == ""
                    ? "N/A"
                    : (timeline.agentNotes ?? "N/A"),
                context: context,
              ),
            ],
          ),
          Column(
            children: [
              _detailRow(
                heading: 'Task Created',
                value: timeline.taskCreated!,
                context: context,
              ),
              SizedBox(
                height: 3.sp,
              ),
              _detailRow(
                heading: 'Description',
                value: timeline.description!,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
      {required String heading, required String value, required context}) {
    return Container(
      width: 210.sp,
      child: RichText(
        maxLines: 7,
        text: TextSpan(
          text: "$heading: ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noteText() => CustomText(
        text: controller.timelineState.value.model?.note == ""
            ? "No notes available"
            : (controller.timelineState.value.model?.note ?? ""),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors().greyText,
      );

  Widget _greyDivider() => Divider(
        thickness: .5,
        color: AppColors().lightGrey,
      );

  Widget _headingText({required String text, required color}) => CustomText(
        text: text,
        fontSize: 15,
        color: color,
        fontWeight: FontWeight.w500,
      );

  Widget _divider() => SizedBox(
        width: 13.w,
        child: Divider(
          color: AppColors().secondary,
          thickness: 2,
        ),
      );
}

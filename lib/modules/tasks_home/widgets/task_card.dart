import 'package:flutter/material.dart';
import 'package:lms_project/constants/app_constants.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/ui/circle_badge.dart';
import 'package:lms_project/utils/ui/ui.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/asset_paths.dart';

class TaskCard extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String dateTime;
  final TaskState taskState;
  final BuildContext context;
  final bool hasOpened;

  TaskCard({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.dateTime,
    required this.taskState,
    required this.context,
    required this.hasOpened,
  }) : super(key: key) {
    var brightness = MediaQuery.of(context).platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  }

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.sp,
      padding: EdgeInsets.symmetric(
        horizontal: pageHorizontalPadding,
        vertical: pageVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: _getBgColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: heading,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
                maxLines: 1,
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomText(
                text: subHeading,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.watch_later,
                    size: 15.sp,
                    color: _getColor(),
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  CustomText(
                    text: dateTime,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _getColor(),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 10.sp,
            bottom: -35.sp,
            child: Image.asset(
              _getCallIcon(),
              height: 50.sp,
            ),
          ),
          !hasOpened
              ? Positioned(
                  right: -5.sp,
                  top: -3.sp,
                  child: CircleBadge(color: _getColor()))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  String _getCallIcon() {
    switch (taskState) {
      case TaskState.overdue:
        return isDarkMode ? taskCallRedDarkIcon : taskCallRedIcon;
      case TaskState.upcoming:
        return isDarkMode ? taskCallOrangeDarkIcon : taskCallOrangeIcon;
      case TaskState.new_task:
        return isDarkMode ? taskCallBlueDarkIcon : taskCallBlueIcon;
      default:
        return isDarkMode ? taskCallRedDarkIcon : taskCallRedIcon;
    }
  }

  Color _getColor() {
    switch (taskState) {
      case TaskState.overdue:
        return AppColors().red;
      case TaskState.upcoming:
        return AppColors().orange;
      case TaskState.new_task:
        return AppColors().secondary;
      default:
        return AppColors().red;
    }
  }

  Color _getBgColor() {
    switch (taskState) {
      case TaskState.overdue:
        return AppColors().redBorder;
      case TaskState.upcoming:
        return AppColors().orangeBorder;
      case TaskState.new_task:
        return AppColors().blueBorder;
      default:
        return AppColors().redBorder;
    }
  }
}

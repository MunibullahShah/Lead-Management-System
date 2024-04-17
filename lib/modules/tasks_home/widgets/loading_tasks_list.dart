import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';
import 'loading_task_card.dart';

class LoadingTasksList extends StatelessWidget {
  const LoadingTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(
          left: pageHorizontalPadding,
          right: pageHorizontalPadding,
          top: pageVerticalPadding,
          bottom: 5.h,
        ),
        itemBuilder: (context, index) {
          return const LoadingTaskCard();
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 30.sp,
          );
        },
        itemCount: 5);
  }
}

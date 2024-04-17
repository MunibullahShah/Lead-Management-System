import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms_project/config/theme/app_colors.dart';
import 'package:lms_project/constants/asset_paths.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:sizer/sizer.dart';

// Constants
double pageHorizontalPadding = 4.w;
double pageVerticalPadding = 2.h;
double onBoardingTopPadding = 5.h;
double borderSize = 0.5;

bool shouldCallBackOnConnectivity = false;

late AndroidNotificationChannel channel;

campaignColorCombinationHelper(String status, String obj) {
  if (status == "ongoing" || status == "onhold" || status == "new") {
    return getCampaignColor[status]![obj];
  } else {
    return getCampaignColor['default']![obj];
  }
}

Map<String, Map<String, dynamic>> getCampaignColor = {
  "ongoing": {
    "backgroundColor": AppColors().greenBackground,
    "backgroundDarkColor": AppColors().secondaryDark,
    "borderColor": AppColors().cardGreenBorder,
    "borderDarkColor": AppColors().cardGreenBorderDark,
    "indicatorColor": AppColors().green,
    "image": outgoingCall,
  },
  "onhold": {
    "backgroundColor": AppColors().orangeBackground,
    "borderColor": AppColors().orangeBorder,
    "backgroundDarkColor": AppColors().secondaryDark,
    "borderDarkColor": AppColors().cardOrangeBorderDark,
    "indicatorColor": AppColors().orange,
    "image": holdCall,
  },
  "new": {
    "backgroundColor": AppColors().blueBackground,
    "borderColor": AppColors().blueBorder,
    "backgroundDarkColor": AppColors().secondaryDark,
    "borderDarkColor": AppColors().cardBlueBorderDark,
    "indicatorColor": AppColors().secondary,
    "image": callNow,
  },
  "closed": {
    "backgroundColor": AppColors().redBackground,
    "borderColor": AppColors().redBorder,
    "backgroundDarkColor": AppColors().secondaryDark,
    "borderDarkColor": AppColors().cardRedBorderDark,
    "indicatorColor": AppColors().red,
    "image": cancelledCall,
  },
  "default": {
    "backgroundColor": AppColors().redBackground,
    "borderColor": AppColors().redBorder,
    "backgroundDarkColor": AppColors().secondaryDark,
    "borderDarkColor": AppColors().cardRedBorderDark,
    "indicatorColor": AppColors().red,
    "image": cancelledCall,
  },
};

Map<String, TaskState> states = {
  "upcoming": TaskState.upcoming,
  "overdue": TaskState.overdue,
  "new_task": TaskState.new_task,
};

String fcmToken = "";

CurrentController currentController = CurrentController.other;

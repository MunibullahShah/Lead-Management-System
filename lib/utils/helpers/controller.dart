import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaign_call_finalize/view/campaign_call_finalize_view.dart';
import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';
import 'package:lms_project/modules/campaign_detail/repository/repository.dart';
import 'package:lms_project/utils/ui/no_internet_page.dart';
import 'package:lms_project/utils/ui/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

import '../../constants/app_constants.dart';

class Controller extends GetxController {
  static RxBool isConnected = false.obs;
  bool granted = false;
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  String viewName = "";

  @override
  void onInit() {
    checkConnection();
    super.onInit();
  }

  checkConnection() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
        Get.to(() => const NoInternetPage());
        shouldCallBackOnConnectivity = true;
      } else {
        if (shouldCallBackOnConnectivity) {
          Get.back();
          shouldCallBackOnConnectivity = false;
        }
        isConnected.value = true;
      }
    });
  }

  void setStream() {
    PhoneState.phoneStateStream.listen((event) async {
      if (event != null) {
        if (event == PhoneStateStatus.CALL_ENDED) {
          await CampaignDetailRepository().updateAgentOnCallStatus(status: 0);
          Get.to(
            () {
              return CampaignCallFinalizeView();
            },
            arguments: viewName,
          );
          dispose();
        } else if (event == PhoneStateStatus.CALL_STARTED) {
          await CampaignDetailRepository().updateAgentOnCallStatus(status: 1);
        }
        status = event;
      }
    });
  }

  getPermission() async {
    if (!granted) {
      await requestPermission();
      // getPermission();
    }
  }

  requestPermission() async {
    await Permission.phone.request().then(
      (status) async {
        switch (status) {
          case PermissionStatus.denied:
            granted = false;
            break;
          case PermissionStatus.restricted:
          case PermissionStatus.limited:
          case PermissionStatus.permanentlyDenied:
            granted = false;
            openAppSettings();
            break;
          case PermissionStatus.granted:
            granted = true;
            break;
        }
      },
    );
  }

  callNumber(String number, int campaignDetailID, String view) async {
    campaignDetailId = campaignDetailID;
    await getPermission();
    if (granted) {
      viewName = view;
      await FlutterPhoneDirectCaller.callNumber(number);
    } else {
      getErrorSnackbar(
          title: "Permission Denied",
          message: "Please grant permission to call from phone settings");
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

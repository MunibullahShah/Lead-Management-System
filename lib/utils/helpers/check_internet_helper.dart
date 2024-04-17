import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../constants/app_constants.dart';
import '../ui/no_internet_page.dart';

Future<void> checkInternetAccess(
  InternetConnectionChecker internetConnectionChecker,
) async {
  InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          {
            if (kDebugMode) {
              print('Data connection is available.');
            }

            if (shouldCallBackOnConnectivity) {
              Get.back();
              shouldCallBackOnConnectivity = false;
            }
            break;
          }
        case InternetConnectionStatus.disconnected:
          {
            Get.to(() => const NoInternetPage());
            if (kDebugMode) {
              print('You are disconnected from the internet.');
            }
            shouldCallBackOnConnectivity = true;
            break;
          }
      }
    },
  );
}

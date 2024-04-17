import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/config.dart';
import 'package:lms_project/modules/splash/view/splash_view.dart';
import 'package:lms_project/utils/helpers/init_notification.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/services/local_notification_service.dart';
import 'package:sizer/sizer.dart';

import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await initializePushNotifications();
  LocalNotificationService().initialize(channel: channel);
  await initNotifications();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('AppLifecycleState.resumed');
      }
      BackendRepository().agentActiveStatus("1");
    } else if (state == AppLifecycleState.inactive) {
      if (kDebugMode) {
        print('AppLifecycleState.inactive');
      }
      BackendRepository().agentActiveStatus("0");
    } else if (state == AppLifecycleState.paused) {
      if (kDebugMode) {
        print('AppLifecycleState.paused');
      }
      BackendRepository().agentActiveStatus("0");
    } else if (state == AppLifecycleState.detached) {
      if (kDebugMode) {
        print('AppLifecycleState.detached');
      }
      BackendRepository().agentActiveStatus("0");
      WidgetsBinding.instance!.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addObserver(this);

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        onInit: () async {},
        debugShowCheckedModeBanner: false,
        title: 'LMS',
        theme: AppTheme().appLightTheme,
        darkTheme: AppTheme().appDarkTheme,
        themeMode: ThemeMode.system,
        home: SplashPage(),
      );
    });
  }
}

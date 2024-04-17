import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../constants/app_constants.dart';
import '../enums/enums.dart';
import '../services/local_notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> initializePushNotifications() async {
  try {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );

    if (!kIsWeb) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('firebase exception -> $e');
    }
  }
}

Future<void> initNotifications() async {
  try {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('${settings.authorizationStatus}');
    }

    firebaseMessaging.getToken().then((token) {
      fcmToken = token.toString() ?? '';
      // if (kDebugMode) {
      print("Here is fcm token >>>>>> $fcmToken <<<<<<");
      // }
      // KeyValueStore.setStr(FCM_TOKEN_KEY, token.toString());
    });

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {}
    });

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    // 2. This method only call when App in forGround
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification androidNotification = message.notification!.android!;

      print(
          'title: ${message.notification!.title}\nbody: ${message.notification!.body}\ndata: ${message.data}');

      if (currentController == CurrentController.other) {
        LocalNotificationService().createAndDisplayNotification(message);
      }
    });
  } catch (ex) {
    if (kDebugMode) {
      print('fcm exception -> ${ex.toString()}');
    }
  }
}

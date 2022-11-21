import 'dart:convert';
import 'dart:io';
import 'package:aqwise_stripe_payment/notifications/request.permission.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:aqwise_stripe_payment/notifications/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../firebase_options.dart';

class FirebaseNotification {
  static Future<void> initFirebaseMessaging() async {
    ///cm initiliaze
    final fcmToken = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      if (kDebugMode) {
        print('success $fcmToken');
      }
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      if (kDebugMode) {
        print(err.toString());
      }
      // Error getting token.
    });

    ///cm ios
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }
    }

    ///cm web
    if (kIsWeb) {
      final fcmToken =
          await FirebaseMessaging.instance.getToken(vapidKey: vappidKey);
      if (kDebugMode) {
        print(fcmToken);
      }
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
      }).onError((err) {
        // Error getting token.
      });
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
      }
      if (kDebugMode) {
        print('Message data: ${message.data}');
      }
      for (var data in message.data.entries) {
        if (kDebugMode) {
          print("[${data.key}] ${data.value}");
        }
      }
      if (message.notification != null) {
        if (await requestBasicPermissionToSendNotifications()) {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                  bigPicture: message.notification!.android!.imageUrl,
                  id: 10,
                  channelKey: 'basic_channel',
                  title: message.notification!.title,
                  body: message.notification!.body,
                  notificationLayout: NotificationLayout.BigPicture,
                  actionType: ActionType.Default));
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  ///onbackground fm
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }
  }

  static Future<void> sendMessage(fcmToken) async {
    var url = "https://fcm.googleapis.com/fcm/send";

    var body = {
      "to": fcmToken,

      ///add to many token
      // "registration_id": [fcmToken],
      "token": fcmToken,
      "data": {
        "hello": "world",
      },
      "android": {
        "priority": "high",
      },
      "notification": {
        "title": "Assalamualaikum",
        "image":
            "https://aqwise.my/wp-content/uploads/2020/11/aqwiselogo3-280x300.png",
        "body": "Welcome to AQ Wise Notification Tutorial s!"
      }
    };

    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Authorization': 'key=$serverKey',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        print(response.statusCode);

        print('message sent');
      } else {
        print(response.statusCode);
        throw ('Error sending message. ');
      }
    } catch (e) {
      print(e);
    }
  }
}

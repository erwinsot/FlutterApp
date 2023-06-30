
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_stat_spider"));

    /* _notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (String? route) async{
      if(route != null){
        Navigator.of(context).pushNamed(route);
      }
    }); */
    _notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (details) => {
      if(details !=null){
        Navigator.of(context).pushNamed(details.toString())
      }

    },);
  }
 

  static void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "easyapproach",
            "easyapproach channel",
            importance: Importance.max,
            priority: Priority.high,
          )
      );


      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
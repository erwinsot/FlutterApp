import 'package:eng_apli/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi{
  static final _notification=FlutterLocalNotificationsPlugin();
  static final onNotifications=BehaviorSubject<String?>();
  static Future notificationDetails()async{
    return  NotificationDetails(
      android:AndroidNotificationDetails(
        "channel id",
        "channel name",
        importance: Importance.max,
        priority: Priority.max
          

      ),
      iOS:IOSNotificationDetails(),
      );
  }

  static Future init({bool initScheduled=false})async{
    const android=AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS=IOSInitializationSettings();
    const settings =InitializationSettings(android: android,iOS: iOS);

    await _notification.initialize(settings,onSelectNotification: (payload)async{
      onNotifications.add(payload);
    });
  }

  static Future ShowNotification({
  int id=0,
  String? title,
  String? body,
  String? payload,
}) async=>_notification.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload
  );

  static void showSheduleNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate

})async=> _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate,tz.local),
      await notificationDetails(),
      uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:true);


  static void showSheduleNotification2({
    int id=0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate

  })async=> _notification.zonedSchedule(
      id,
      title,
      body,
      _sheduleDaily(Time(8)),
      await notificationDetails(),
      uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:true,
      matchDateTimeComponents: DateTimeComponents.time
  );

  static void periodicalNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
})async=> _notification.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      await notificationDetails(),
      payload: await daPayload2(),
      androidAllowWhileIdle: true
      );

  static tz.TZDateTime _sheduleDaily(Time time){
    final now=tz.TZDateTime.now(tz.local);
    final sheduleDate=tz.TZDateTime(tz.local, now.year,now.month,now.day);
    return sheduleDate.isBefore(now)
        ? sheduleDate.add(Duration(days: 1))
        :sheduleDate;
  }


}
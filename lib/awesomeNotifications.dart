import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eng_apli/globals.dart';
import 'package:eng_apli/utils.dart';
import 'models/models.dart';



Future <void>createPlantFoodNotification(String? body, Map<String,String> payload)async{
  await AwesomeNotifications().
  createNotification(
      content: NotificationContent(id: createUniqueId(),
      channelKey: "basic_channel",
      title: '${Emojis.animals_bear} HORA DE ESTUDIAR MK  ${Emojis.animals_bear}',
      body: ' Remember that is this? ${body}  ${Emojis.animals_fox} ',
      payload:payload ,
      summary: "HOLA sapo hp!!",

      notificationLayout: NotificationLayout.Messaging,


      ),
          actionButtons: [
            NotificationActionButton(
              key: 'Find out',
              label: 'Find out',
            )
      ]
  );
}
Future <void >createWaterReminderNotification(NotificationSchedule notificationWeekAndTime)async{
  await AwesomeNotifications().createNotification(
      content: NotificationContent(id: createUniqueId(),
          channelKey: 'scheduled_channel',
        title: '${Emojis.money_money_bag+Emojis.plant_cactus}',
        body: 'vuela comno pájaro',
        notificationLayout: NotificationLayout.Default,
      ),
    actionButtons: [
      NotificationActionButton(
          key: 'Mark_Done',
          label: 'Mark done',
      )
    ],
      schedule: NotificationCalendar(
      repeats: true,
  )
  );

}

Future <void>createRepeatNotification()async{
  String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  String utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'scheduled_channel',
          title: '${Emojis.money_money_bag+Emojis.plant_cactus} every minute',
          body:'Tu palabra a recordar es ',
          payload: await daPayload(),
          notificationLayout: NotificationLayout.BigText,
          bigPicture: 'asset://assets/images/melted-clock.png'),
          schedule: NotificationInterval(interval: 60, timeZone: localTimeZone, repeats: true),
          actionButtons: [
            NotificationActionButton(
                key: "View", label: "View answer")
          ]
  );
}
Future <void> cancellshueNotification()async{
  await AwesomeNotifications().cancelAllSchedules();
}

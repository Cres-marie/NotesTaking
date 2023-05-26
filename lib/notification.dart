// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// class SmolleyNotification{
//   static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
//     var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher.png');
//     var initializationSettings = new InitializationSettings(android: androidInitialize);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//   static Future showNotification({var id=0,required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln}) async{
//     AndroidNotificationDetails androidNotificationDetails = new AndroidNotificationDetails('channelId', 'channelName', playSound: true, importance: Importance.max, priority: Priority.high);

//     var noti = NotificationDetails(android: androidNotificationDetails,);
//     await fln.show(id, title, body, noti);
//   }
// }
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SmolleyNotification{
   void smolleyNoti() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,category: NotificationCategory.Event, channelKey: 'channelKey',title: 'Smolley', body: 'You have added an Event to the calender!'));
  }
  // void dailyNotification(DateTime time, String title, String body){
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(id: Random().nextInt(999), channelKey: 'channelKey',title: title, body: body),
  //     schedule: NotificationCalendar(
  //       year: time.year,
  //       month: time.month,
  //       day: time.day,
  //       hour: time.hour,
  //       minute: time.minute
  //     )
  //     );
  // }
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin )async{
     AndroidInitializationSettings initialiseAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
     final InitializationSettings initializationSettings = InitializationSettings(android: initialiseAndroid);
     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  static Future ShowNotification({required String title, required String body, var payload,required DateTime time, required FlutterLocalNotificationsPlugin fn}) async{
    AndroidNotificationDetails androidnotificationdetails = new AndroidNotificationDetails(
      'Smolley key',
      'Smolley channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var notification = NotificationDetails(android: androidnotificationdetails);
       tz.initializeTimeZones();
    await fn.zonedSchedule(
      Random().nextInt(999),
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      await notification,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
  // static Future dailyNotification({required String title, required String body, var payload,required DateTime time, required FlutterLocalNotificationsPlugin fn}) async{
  //    AndroidNotificationDetails androidnotificationdetails = new AndroidNotificationDetails(
  //     'Smolley key',
  //     'Smolley channel',
  //     playSound: true,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var notification = NotificationDetails(android: androidnotificationdetails);
  //   var today = tz.TZDateTime(tz.local, tz.TZDateTime.now(tz.local).year,tz.TZDateTime.now(tz.local).month,tz.TZDateTime.now(tz.local).day, time.hour, time.minute);
    
  //   while(){
  //     fn.zonedSchedule(Random().nextInt(999), title, body, scheduledDate, notificationDetails, uiLocalNotificationDateInterpretation: uiLocalNotificationDateInterpretation)
  //   }
    
  // }
}


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_notification');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId', 
          'Reminder',
          importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 1, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> scheduleNotification(DateTime dueDate) async {
  // Set the time to midnight (00:00)
    try {
      DateTime scheduledDate = DateTime(dueDate.year, dueDate.month, dueDate.day, 0, 0);
      
      await notificationsPlugin.zonedSchedule(
          0,
          'Reminder!',
          'You have a task due today!',
          tz.TZDateTime.from(scheduledDate, tz.local),
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exact,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    } on Exception catch (e) {
      print(e);
    }
  }
}
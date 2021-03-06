import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:fyp_dieta/src/utils/local_storage.dart';

const String mealChannelId = 'meal_channel_id';
const String mealChannelName = 'meal_channel';
const String mealChannelDescription = 'daily notification';
const String lunchTitle = 'Lunch time !';
const String lunchContent = 'Record your lunch & check the calories';
const String dinnerTitle = 'Dinner time !';
const String dinnerContent = 'Record your dinner & check the calories';

tz.TZDateTime _nextInstanceOfOnePM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 12);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfSevenPM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 19);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

class Notifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> loadNotification() async {
    // set local time zone
    tz.initializeTimeZones();
    // request permits for IOS
    if (!await hasIosNotificationRights()) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    if (await getDietNotifications()) {
      Notifications.scheduledDinnerNotification();
      Notifications.scheduledLunchNotification();
    }
  }

  static Future<void> scheduledLunchNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        lunchTitle,
        lunchContent,
        _nextInstanceOfOnePM(),
        const NotificationDetails(
          iOS: IOSNotificationDetails(threadIdentifier: mealChannelId),
          android: AndroidNotificationDetails(
              mealChannelId, mealChannelName, mealChannelDescription),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static Future<void> show() async {
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: 'thread_id');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  static Future<void> scheduledDinnerNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        dinnerTitle,
        dinnerContent,
        _nextInstanceOfSevenPM(),
        const NotificationDetails(
          iOS: IOSNotificationDetails(threadIdentifier: mealChannelId),
          android: AndroidNotificationDetails(
              mealChannelId, mealChannelName, mealChannelDescription),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}

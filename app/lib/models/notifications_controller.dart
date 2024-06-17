import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationsController {
  static init() {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_output_onlinepngtools',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Basic Channel Notifications'
        ),
        NotificationChannel(
          channelKey: 'schedule_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Scheduled Channel Notifications'
        )
      ],
      debug: true
    );
  }

  static checkIfAllowed() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) AwesomeNotifications().requestPermissionToSendNotifications();
    });
  }

  static sendSimpleNotification(String title, String content) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: content
      )
    );
  }

  static sendScheduledNotification(String title, String content, int interval, bool repeat) async{
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'schedule_channel',
        title: title,
        body: content,
        category: NotificationCategory.Reminder,

      ),
      schedule: NotificationInterval(interval: interval, repeats: repeat, timeZone: localTimeZone, preciseAlarm: true)
    );
  }
}
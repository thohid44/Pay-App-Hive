import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); 

  final AndroidInitializationSettings _androidInitializationSettings =
  AndroidInitializationSettings('note');

  void initializeNotifications() async{
    InitializationSettings initializationSettings =
    InitializationSettings(
      android: _androidInitializationSettings
    );
   await _flutterLocalNotificationsPlugin.
    initialize(initializationSettings);


  }

  void sendNotification(String title, String body) async{
    
  AndroidNotificationDetails androidNotificationDetails = 
  AndroidNotificationDetails("channelId", "channelName", 
  
  importance: Importance.max, 
  priority: Priority.high
  );
 NotificationDetails notificationDetails = 
 NotificationDetails(android: androidNotificationDetails);

   await _flutterLocalNotificationsPlugin.
    show(0, "title", "body", notificationDetails);

  }
}
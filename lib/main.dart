// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:pay_app/Hive/hive_homePage.dart';
import 'package:pay_app/fetch_data.dart';
import 'package:pay_app/notificaion/push_notification_home.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
enum SdkType { TESTBOX, LIVE }
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if(task=='uniquekey'){
      // do the task in Backend for how and when to send notification 
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2')); 
      Map<String,dynamic> resData = json.decode(response.body); 
      print(resData['title']);
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidNotificationDetails androidNotificationChannelSpecifics = 
      AndroidNotificationDetails("your channel id", 'your channel name', 
   importance: Importance.max, priority: Priority.high, 
      showWhen: false, 
      );
    
    const   NotificationDetails platformChannelSpecifics =  NotificationDetails(
        android: androidNotificationChannelSpecifics
      );
      await flutterLocalNotificationsPlugin.show(
        0, resData['title'], resData['body'],
         platformChannelSpecifics, 
         payload: 'item x');
         return Future.value(true); 


    }
    return Future.value(true);
  });
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings  initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher'
  );
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
   flutterLocalNotificationsPlugin.initialize(initializationSettings, 
  );
  
  Workmanager().initialize(callbackDispatcher, 
  isInDebugMode: true); 
  Workmanager().registerPeriodicTask("2","uniquekey", frequency: Duration(seconds: 5), 
  
  inputData:{"title":'title'} ); 


  
  await Hive.initFlutter(); 
  await Hive.openBox('vocabulary'); 

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

 Future<void> selectNotification(String payload) async{
if(payload != null){

}
 }
class _MyAppState extends State<MyApp> {
  
  var _key = GlobalKey<FormState>();
  dynamic formData = {};
  SdkType _radioSelected = SdkType.TESTBOX;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FetchData()
    );
  }}

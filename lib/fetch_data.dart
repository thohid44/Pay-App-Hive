import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:pay_app/model/fetch_data_model.dart';
import 'package:workmanager/workmanager.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {

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
  fetchData() async{
    List<FetchDataModel> list = []; 
  var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")); 
  var res = json.decode(response.body); 
   for (var element in res) {
     FetchDataModel list2 = FetchDataModel.fromJson(element); 
    //S print(list2.runtimeType.hashCode.bitLength);
   
     list.add(list2); 
       
   }
   return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Fetch Data"),), 

      body: FutureBuilder(
        future: fetchData(), 
        builder: ((context,AsyncSnapshot snapshot) {
          return  ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(context, index) {
            return ListTile(
            
            title: Text(snapshot.data[index].title.toString()),
            );
          });
        }),
      ),
    );
  }
}
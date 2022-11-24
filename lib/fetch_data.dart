import 'dart:convert';

import 'package:flutter/material.dart';
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

  void initState(){
 Workmanager().initialize(callbackDispatcher,isInDebugMode: true); 
    super.initState();
     Workmanager().registerPeriodicTask("2","uniquekey1", frequency: Duration(seconds: 5), 
  
  inputData:{"title":datalist[0], } ); 


  
  }
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if(task=='uniquekey1'){
      // do the task in Backend for how and when to send notification 
     
    
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
        0,datalist[0],datalist[0] ,
         platformChannelSpecifics, 
         payload: 'item x');
         return Future.value(true); 


    }
    return Future.value(true);
  });
}
  
  final TextEditingController title = TextEditingController(); 
  
   List datalist = ['dbody'];
   insertData(String title){
   datalist.add(title); 

   print(datalist.length); 
   }
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Fetch Data"),), 

      body: ListView(
        children: [
          Form(
            key: key,
            child: Column(
            children: [
              Container(
              margin: EdgeInsets.all(20),
                child: TextField(
            controller: title,
          ),
              ),
       

          ElevatedButton(onPressed: (){
          insertData(title.text); 
          }, child: Text("Insert Data"))
            ],
          ), 
          
          
          ), 

          // Expanded(
          //   child: Container(
          //     child: ListView.builder(
          //       itemCount: datalist.length,
          //       itemBuilder:(context,index){
          //       return ListTile(title: Text(datalist[index]),);
          //     }),
          //   ),
          // )
        ],
      )
      
    );
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
}
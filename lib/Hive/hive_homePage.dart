import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHomePage extends StatefulWidget {
  const HiveHomePage({Key? key}) : super(key: key);

  @override
  State<HiveHomePage> createState() => _HiveHomePageState();
}

class _HiveHomePageState extends State<HiveHomePage> {
  
  var color = false; 
  @override
  Widget build(BuildContext context) {
    var words = nouns.take(1150).toList();

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Hive Off Line Database"),),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('vocabulary').listenable(),
      
       builder:((context, box, child) {
         return ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index){
     var word = words[index];
            var box = Hive.box('vocabulary'); 
             var wrd = box.get(index) !=null; 
        return ListTile(
          title: Text(word),
          trailing: IconButton(
            onPressed: () async{
          
              if(wrd){
                await box.delete(index);
      const  snackBar = SnackBar(content: Text("Remove Successfully"), backgroundColor: Colors.red,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar); 
              }else{
                await box.put(index, word);
                      const  snackBar = SnackBar(content: Text("Added Successfully"), backgroundColor: Colors.blue,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar); 
              }

        
        
          },
           icon: Icon( wrd?Icons.favorite: Icons.favorite_border , color:Colors.red ,)),
        );
      });
       }))
    ));
  }
}
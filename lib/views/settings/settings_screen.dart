import 'package:flutter/material.dart';
import 'package:splitwise_app/views/settings/about.dart';
import 'package:splitwise_app/views/settings/terms.dart';
import 'package:splitwise_app/widgets/restart_screen.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,title:
       const Text('Settings',style: TextStyle(
        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
           
          children: [
            SizedBox(height: 160,),
          
          Material(
            elevation: 2,
            child: Container(height: 60,width: 360,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => About(),));
                },
                child: const ListTile(leading: Icon(Icons.info),title: Text("About us"),
                trailing: Icon(Icons.arrow_forward_ios),),
              ),
            ),),),
         
          SizedBox(height: 20,),
           Material( 
            elevation: 2,
            child: Container(height: 60,width: 360,
            child: Center(
              child: GestureDetector(onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Terms(),));
              },
                child: const ListTile(leading: Icon(Icons.description),title: Text("Terms and Conditions"),
                trailing: Icon(Icons.arrow_forward_ios,),),
              ),
            ),),
          ),
          SizedBox(height: 20,),
           const Material(
            elevation: 2,
           
          ),
          SizedBox(height: 40,),
          GestureDetector(onTap: () {
            reset().resetApp(context);
            
           
          },
            child: Container(height:60,width: 360,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:Color.fromARGB(255, 92, 172, 162),),
            child: Align(child: Text('Reset')),
            ),
          )
          ],
        
        ),
      ),
    );
  }
} 
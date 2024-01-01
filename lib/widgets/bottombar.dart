
import 'package:flutter/material.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';
import 'package:splitwise_app/views/chart_screen.dart';
import 'package:splitwise_app/views/description_screen.dart';
import 'package:splitwise_app/views/home_screen.dart';
import 'package:splitwise_app/views/settings/settings_screen.dart';



class bottombar extends StatefulWidget {
  int initialIndex =0;
   bottombar({super.key});

  @override
  State<bottombar> createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
 int myindex = 0; 

final pages = [
 Homescreen(),
Descriptionscreen(expense: ExpenseList(description: '', amount: '',image: '')),
chart_screen(),
 Settings()
  
];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[myindex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              myindex =index;
            });
          },
          currentIndex: myindex,
          items: [
          
          
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home,color: myindex==0?Colors.black:Colors.grey,),label: 'Home',),
             BottomNavigationBarItem(
            icon: Icon(Icons.description,color: myindex==1?Colors.black:Colors.grey,),label: 'Description'), 
             BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle,color: myindex==2?Colors.black:Colors.grey,),label: 'Chart'), 
             BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: myindex==3?Colors.black:Colors.grey,),label: 'Settings'), 

        ]),
        
       
        )
    
          
        );
        
        
    
      
    
  }
}
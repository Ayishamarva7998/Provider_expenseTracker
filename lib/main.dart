import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/addexpense_provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';
import 'package:splitwise_app/controller/edit_provider.dart';
import 'package:splitwise_app/controller/total_provider.dart';
import 'package:splitwise_app/views/splash_screen.dart';
import 'package:splitwise_app/functions/expense_fn.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';


 const String SAVE_KEY_NAME = 'user_logged_in';

void main()async {


 WidgetsFlutterBinding.ensureInitialized(); 
 await Hive.initFlutter();
if(!Hive.isAdapterRegistered(ExpenseListAdapter().typeId))
{
  Hive.registerAdapter(ExpenseListAdapter());

}

  runApp( const MyApp()); 
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  

 
  @override
  Widget build(BuildContext context) {
 
   
   
    
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AddexpenseProvider(),),
      ChangeNotifierProvider(create: (context) => editProvider(),),
      ChangeNotifierProvider(create: (context)=>DbProvider(),),
      ChangeNotifierProvider(create: (context)=>totalprovider())

      
    ],
      child: const MaterialApp(
        title: 'EasyPay',
        debugShowCheckedModeBanner: false,
       home:Splashscreen(),
        ),
    );
    
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';
import 'package:splitwise_app/widgets/adddexpense_screen.dart';



class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
     Provider.of<DbProvider>(context,listen: false).getAllexpense();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Explore Easy Tracker',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 10, 84, 74), ),),
              ),
              SizedBox(height: 70),
           
              ClipRRect(
                
                  child: Lottie.asset('assets/Animation - 1701449205719.json',
                  
                      height: screenHeight * 0.4, width: screenWidth * 0.9)),
                     
             
             
              Container(
                height: screenHeight * 0.1,
               
              ),
              SizedBox(height: screenHeight * 0.10),
           
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Addexpense()));
                },
                child: Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 22, 140, 124),
                  ),
                  child: const Center(
                    child: Text('Add Expenses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

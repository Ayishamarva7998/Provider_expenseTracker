
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/addexpense_provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';
import 'package:splitwise_app/controller/edit_provider.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';
import 'package:splitwise_app/views/description_screen.dart';
import 'package:splitwise_app/widgets/bottombar.dart';



class EditData extends StatefulWidget {
  final String description;
  final String amount;

  int index;

  EditData({
    super.key,
    required this.description,
    required this.amount,
    required this.index,
  });

  @override
  State<EditData> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<EditData> {
 
  
  @override
  void initState() {
    super.initState();
     final pro =Provider.of<editProvider>(context,listen: false);
     pro. descriptioneController.text = widget.description;
     pro.amounteController.text = widget.amount;
  
  }

  @override
  Widget build(BuildContext context) {
    final pro =Provider.of<editProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 42, 120, 114),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Edit Expense'),
        ),
        body: SingleChildScrollView(
          child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   Consumer<AddexpenseProvider>(builder: (context, value, child) => 
                      CircleAvatar(
                       radius: 50,
                       backgroundImage:
                          value. selectImage != null ? FileImage( value.selectImage!) : null,
                     ),
                   ),
                   const SizedBox(height: 20),
                   Container(
                     height: 80,
                     width: 320,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(15.0),
                       child: Consumer<editProvider>(builder: (context, value, child) => 
                          TextFormField(
                           controller:value. descriptioneController,
                           style: TextStyle(color: Colors.black),
                           decoration: const InputDecoration(
                             border: InputBorder.none,
                             hintText: 'Edit your expense',
                             hintStyle: TextStyle(color: Colors.grey),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   Container(
                     height: 80,
                     width: 320, 
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(15.0),
                       child: Consumer<editProvider>(builder: (context, value, child) => 
                          TextFormField(
                           controller:value. amounteController,
                           inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly
                           ],
                           keyboardType: TextInputType.number,
                           style: TextStyle(color: Colors.black),
                           decoration: const InputDecoration(
                             border: InputBorder.none,
                             hintText: 'Edit amount',
                             hintStyle: TextStyle(color: Colors.grey),
                           ),
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(
                     height: 10,
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   ElevatedButton(
                     onPressed: () async{
                       
                       await update();
                       Navigator.pop(context);
                      

                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                     ),
                     child: const Text(
                       "Done",
                       style: TextStyle(color: Colors.black),
                     ),
                   )
                 ],
               ),
             ),
           ],
                      ),
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromARGB(255, 34, 32, 32),
          height: 320.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Choose your daily routine",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 102, 91, 91),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Descriptionscreen(
                                    expense: ExpenseList(
                                        description: '', amount: '', image: ''),
                                  )),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 10),
                            Text(
                              'Create your own habit',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task),
                            SizedBox(width: 10),
                            Text(
                              'Create your own Task',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

 
Future<void> update() async {
  final update = Provider.of<editProvider>(context, listen: false);

  final editedDescription = update.descriptioneController.text.trim();
  final editedAmount = update.amounteController.text.trim();

  if (editedDescription.isEmpty || editedAmount.isEmpty) {
   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill in all fields."),
      ),
    );
  } else {
    final data = ExpenseList(
      description: editedDescription,
      amount: editedAmount,
      image: update.selectImage?.path ?? '',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Expense updated successfully."),
      ),
    );

    await Provider.of<DbProvider>(context, listen: false)
        .editExpense(widget.index, data);

   
  }
}

}
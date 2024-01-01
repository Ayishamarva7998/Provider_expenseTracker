import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';
import 'package:splitwise_app/controller/total_provider.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';
import 'package:splitwise_app/widgets/bottombar.dart';
import 'package:intl/intl.dart';
import 'package:splitwise_app/widgets/edit_screen.dart';
   
class Descriptionscreen extends StatefulWidget {
  ExpenseList expense;
  Descriptionscreen({Key? key, required this.expense}) : super(key: key);

  @override
  State<Descriptionscreen> createState() => _FriendsscreenState();
}

class _FriendsscreenState extends State<Descriptionscreen> {
  String _search = '';

  List<ExpenseList> details = [];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }  
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DbProvider>(context, listen: false).getAllexpense();
  }

  void filteredData() {
    final dbProvider = Provider.of<DbProvider>(context,listen: false);
    final filteredExpense = dbProvider.expenceList
        .where((expenselist) => expenselist.description
            .toLowerCase()
            .contains(_search.toLowerCase()))
        .toList();
      


    dbProvider.filteredDataValue(filteredExpense);
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Are you sure you want to delete this expense?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                 Provider.of<DbProvider>(context,listen: false);  
                                   
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => bottombar(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Color.fromARGB(255, 22, 140, 124),
          elevation: 0,
          title: const Text(
            'Friends',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_month),
                color: Colors.black)
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'search expense',
                  fillColor: const Color.fromARGB(255, 237, 235, 235),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _search = value;
                    filteredData();
                    // Provider._search=value;
                  });
                  // Provider.of<DbProvider>(context).filteredDataValue()
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 210),
              child: Consumer<totalprovider>(
                builder: (context, totalProvider, child) {
                  return Text(
                    "Total Amount:-${totalProvider.total(Provider.of<DbProvider>(context,listen: false).expenceList)}",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Builder(builder: (context) { 
                return Consumer<DbProvider>(
                    builder: (BuildContext ctx, dbProvider, Widget? child) {
                  final list = dbProvider.filteredExpense.isNotEmpty
                      ? dbProvider.filteredExpense
                      : dbProvider.expenceList;
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      final data = list[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundImage: data.image != null
                              ? FileImage(File(data.image!))
                              : null,
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                  image: AssetImage('assets/circleavatar.png'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        title: Text(data.description),
                        subtitle: Text(data.amount.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditData(
                                      description: data.description,
                                      amount: data.amount,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<DbProvider>(context,listen: false)
                                    .deleteExpense(index);
                                    _showDeleteConfirmationDialog();
                                    
                              },
                              icon: Image.asset(
                                "assets/delete.png",
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: list.length,
                  );
                });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

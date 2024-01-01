import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/addexpense_provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';
import 'package:splitwise_app/views/description_screen.dart';
import 'package:splitwise_app/widgets/bottombar.dart';

import 'package:splitwise_app/model/expense/expenselist_model.dart';
import 'package:image_picker/image_picker.dart';

class Addexpense extends StatelessWidget {
  Addexpense({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => bottombar(),
            ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<AddexpenseProvider>(
        builder: (context, value, child) => 
         Form(
          key: value. formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Add expenses',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pickedImage(context),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromARGB(255, 22, 140, 124),
                    backgroundImage:value. selectImage != null
                        ? FileImage(value. selectImage!)
                        : AssetImage("assets/circleavatar.png") as ImageProvider,
                  ),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller:value. descriptionController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description),
                          hintText: 'description',
                          fillColor: Color.fromARGB(255, 231, 230, 230),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: value.amountController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.currency_rupee),
                          hintText: 'amount',
                          fillColor: Color.fromARGB(255, 231, 230, 230),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          onAddExpenseButtonClicked(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 22, 140, 124),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddExpenseButtonClicked(BuildContext context) async {
    final addbutton=Provider.of<AddexpenseProvider>(context,listen: false);
    if (addbutton.formKey.currentState!.validate()) {
      final _description = addbutton.descriptionController.text.trim();
      final _amount = addbutton.amountController.text.trim();
      final _select = addbutton.selectController.text.trim();

      final _expense = ExpenseList(
        description: _description,
        amount: _amount, 
        image: addbutton. selectImage?.path,
      );
      addbutton.descriptionController.clear();
      addbutton.amountController.clear();
     Provider.of<DbProvider>(context,listen: false).addExpense(_expense);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Descriptionscreen(
            expense: ExpenseList(description: '', amount: '', image: '')),
      ));
    }
  }

  Future<void> pickedImage(BuildContext context) async {
    final addbuttonimg=Provider.of<AddexpenseProvider>(context,listen: false);
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      
      addbuttonimg.selectImage = imageFile;
    }
  }
}

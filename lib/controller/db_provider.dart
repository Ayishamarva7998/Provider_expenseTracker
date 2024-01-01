import 'package:flutter/material.dart';
import 'package:splitwise_app/service/db_service.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';

class DbProvider extends ChangeNotifier {
  String _search = '';
  List<ExpenseList> filteredExpense = [];
  List<ExpenseList> expenceList = [];
  DbServices dbServices = DbServices();
  Future<void> getAllexpense() async {
    expenceList = await dbServices.getAllexpense();
    notifyListeners();
  }

  Future<void> addExpense(ExpenseList value) async {
    await dbServices.addExpense(value);
    await getAllexpense();
  }

  Future<void> deleteExpense(int index) async {
    await dbServices.deleteExpense(index);
    notifyListeners();
    await getAllexpense();
    notifyListeners();
  }

  Future<void> editExpense(index, ExpenseList value) async {
    await dbServices.editExxpense(index, value);
    notifyListeners();
    await getAllexpense();
    notifyListeners();
  }

  // // search function
  void filteredDataValue (List <ExpenseList> value) async {
    filteredExpense = value;
    
    notifyListeners();
  }
  // //chart calcultion

  double calculateTotalCost(List<ExpenseList> expense) {
    double totalCost = 0;
    for (var expense in expense) {
      totalCost += double.parse(expense.amount);
    }
    return totalCost;
  }
}

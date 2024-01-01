import 'package:flutter/material.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';

class totalprovider extends ChangeNotifier {
  double totalamount = 0;

  double total(List<ExpenseList> expenseList) {
    totalamount = 0; // Reset totalamount before calculating again

    for (var expense in expenseList) {
      if (expense.amount != null && expense.amount.isNotEmpty) {
        try {
          totalamount += double.parse(expense.amount);
        } catch (e) {
          print('Error parsing amount: ${expense.amount}');
        }
      }
    }

    notifyListeners();
    return totalamount;
  }
}
  
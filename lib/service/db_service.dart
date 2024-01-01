import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';

class DbServices{
   Future<List<ExpenseList>> getAllexpense()async{
     final expenseDB = await Hive.openBox<ExpenseList>('expense_db');
     return expenseDB.values.toList();
   }
   Future<void> addExpense(ExpenseList value)async{
   final expenseDB = await Hive.openBox<ExpenseList>('expense_db');
   
   await expenseDB.add(value);
   } 
    Future<void> deleteExpense(int index) async {
  final expenseDB = await Hive.openBox<ExpenseList>('expense_db');
  expenseDB.deleteAt(index);
}
 Future<void> editExxpense(index,ExpenseList value ) async {
  final expenseDB = await Hive.openBox<ExpenseList>('expense_db');
  expenseDB.putAt(index, value);
}
   

}
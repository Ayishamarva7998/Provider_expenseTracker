import 'package:flutter/material.dart';
import 'package:splitwise_app/model/expense/expenselist_model.dart';
import 'package:splitwise_app/views/chart_screen.dart';
import 'package:splitwise_app/views/description_screen.dart';
import 'package:splitwise_app/views/home_screen.dart';
import 'package:splitwise_app/views/settings/settings_screen.dart';

class BottombarProvider extends ChangeNotifier{
  final List tabs =[
    Homescreen(),
    Descriptionscreen(expense: ExpenseList(description: '', amount: '', image: '',)),
    const chart_screen(),
    const Settings()

  ];
  int currentIndex = 0;



  void indexColors(int newIndexColor){
    currentIndex =newIndexColor;
    notifyListeners();
  }
}
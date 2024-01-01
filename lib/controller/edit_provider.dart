import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_app/controller/addexpense_provider.dart';
import 'package:splitwise_app/controller/db_provider.dart';




class editProvider extends ChangeNotifier{
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final descriptioneController =TextEditingController();
final amounteController =TextEditingController();
  File? selectImage;
  final selectController = TextEditingController();


 
}
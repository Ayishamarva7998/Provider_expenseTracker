import 'dart:io';

import 'package:flutter/material.dart';

class AddexpenseProvider extends ChangeNotifier{
final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final   amountController = TextEditingController();
  final selectController =TextEditingController();

  File? selectImage;
  final _selectController = TextEditingController();
   TextEditingController descriptioneController = TextEditingController();
  TextEditingController amounteController = TextEditingController();
  File? selecteImage;
  final selecteController = TextEditingController();

  

}


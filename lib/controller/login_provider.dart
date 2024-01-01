import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  final usernameController =TextEditingController();
  final passwordController = TextEditingController();

  final formKey =GlobalKey<FormState>();
}
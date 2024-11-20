import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isColorOne = false.obs;
  RxBool isColorTwo = false.obs;

  void submitForm(BuildContext context) {

    print(emailController.text);
    print(passwordController.text);
  
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando Sesion')),
      );

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rellene todos los campos')),
      );
    }
  }


  // Método para liberar recursos
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

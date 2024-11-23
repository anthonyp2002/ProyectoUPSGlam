import 'package:apsglam/class/user.dart';
import 'package:apsglam/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordresetController = TextEditingController();

  RxBool isColorOne = false.obs;
  RxBool isColorTwo = false.obs;
  RxBool isColorThre = false.obs;
  RxBool isColorFour = false.obs;
  RxBool isColorFive = false.obs;

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {

    final User usuarios = User(
          name: nameController.text,
          telefono: phoneController.text,
        //  descripcion: "",
          email: emailController.text,
          password: passwordController.text);
    
    saveUser(usuarios);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creando Cuenta')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rellene todos los campos')),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

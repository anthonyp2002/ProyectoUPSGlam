import 'package:apsglam/class/user.dart';
import 'package:apsglam/controller/inicio_service.dart';
import 'package:apsglam/routes/routes.dart';
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

  void submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final User usuarios = User(
          name: nameController.text,
          telefono: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
          profileImgUrl: "https://firebasestorage.googleapis.com/v0/b/db-cp-5ffd3.firebasestorage.app/o/Perfil%2Fuser.png?alt=media&token=235f6073-7887-42d1-b454-adee66d6bb49",
          );

      await saveUser(usuarios);
      Get.put(InicioService());
      Get.offNamed(RoutesClass.getInicioRoute());
      // ignore: use_build_context_synchronously
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

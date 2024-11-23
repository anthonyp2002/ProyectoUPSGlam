import 'package:apsglam/controller/inicio_service.dart';
import 'package:apsglam/routes/routes.dart';
import 'package:apsglam/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isColorOne = false.obs;
  RxBool isColorTwo = false.obs;

  void submitForm(BuildContext context) async {

    bool checkUser = await verificarCredenciales(emailController.text, passwordController.text);
    
    if (formKey.currentState!.validate()) {

      if(!checkUser){ 
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error ponga bien sus credenciales')),
        );
      }else{
      // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Iniciando Sesion')),
        );
            // ignore: unused_local_variable
        Get.put(InicioService());
        Get.offNamed(RoutesClass.getInicioRoute());
      }

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

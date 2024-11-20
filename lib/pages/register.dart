import 'package:apsglam/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  final RegisterController controller = RegisterController();
  Register({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff120C24),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white30,size: 30,),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Crear una Cuenta",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      const Row(
                        children: [
                          Text(
                            "Por favor complete el formulario",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Obx(
                                () => Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: controller.isColorOne.value
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      margin: const EdgeInsets.only(
                                          bottom: 15, top: 25),
                                      child: TextFormField(
                                        controller: controller.nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '    Please enter some text';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          alignLabelWithHint: false,
                                          label: Text(
                                            "NOMBRES",
                                            style: TextStyle(
                                                color: Colors.white30),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.isColorOne.value =
                                              value.isNotEmpty;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: controller.isColorTwo.value
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: TextFormField(
                                        controller: controller.phoneController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '    Please enter some text';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          alignLabelWithHint: false,
                                          label: Text(
                                            "TELEFONO",
                                            style: TextStyle(
                                                color: Colors.white30),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.phone_android_sharp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.isColorTwo.value =
                                              value.isNotEmpty;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: controller.isColorThre.value
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: TextFormField(
                                        controller: controller.emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '    Please enter some text';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          alignLabelWithHint: false,
                                          label: Text(
                                            "CORREO",
                                            style: TextStyle(
                                                color: Colors.white30),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.isColorThre.value =
                                              value.isNotEmpty;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: controller.isColorFour.value
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: TextFormField(
                                        controller:
                                            controller.passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '    Please enter some text';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          alignLabelWithHint: false,
                                          label: Text(
                                            "CONTRASEÑA",
                                            style: TextStyle(
                                                color: Colors.white30),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.isColorFour.value =
                                              value.isNotEmpty;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: controller.isColorFive.value
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: TextFormField(
                                        controller:
                                            controller.passwordresetController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '    Please enter some text';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          alignLabelWithHint: false,
                                          label: Text(
                                            "CONFIRMAR CONTRASEÑA",
                                            style: TextStyle(
                                                color: Colors.white30),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.isColorFive.value =
                                              value.isNotEmpty;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Center(
                                child: SizedBox(
                                  width: 225,
                                  height: 65,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.submitForm(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 63, 183, 169),
                                    ),
                                    child: const Text(
                                      'Ingresar',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 55)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Ya tienes una cuenta?",
                                        style: TextStyle(
                                          color: Colors
                                              .white30, 
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: const Text(
                                          "Iniciar Sesion",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 63, 183,
                                                169), 
                                            decoration: TextDecoration
                                                .underline, 
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

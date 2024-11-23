import 'package:apsglam/controller/home_controller.dart';
import 'package:apsglam/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatelessWidget {
  final HomeController controller = HomeController();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff120C24),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Container(
                  width: 220,
                  padding: const EdgeInsets.only(top: 80, bottom: 50),
                  child: const Image(
                    image: AssetImage('assets/Img-Login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                const Row(
                  children: [
                    Text(
                      "Por favor inicia sesión para continuar",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
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
                                    borderRadius: BorderRadius.circular(18)),
                                margin:
                                    const EdgeInsets.only(bottom: 15, top: 25),
                                child: TextFormField(
                                  controller: controller.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '    Please enter some text';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    alignLabelWithHint: false,
                                    label: Text(
                                      "Correo",
                                      style: TextStyle(color: Colors.white30),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
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
                                decoration: BoxDecoration(
                                    color: controller.isColorTwo.value
                                        ? Colors.white24
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(18)),
                                child: TextFormField(
                                  controller: controller.passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '    Please enter some text';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    alignLabelWithHint: false,
                                    label: Text(
                                      "Contraseña",
                                      style: TextStyle(color: Colors.white30),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.isColorTwo.value =
                                        value.isNotEmpty;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 10),
                        child: Center(
                          child: SizedBox(
                            width: 225,
                            height: 65,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.submitForm(context);
                                Get.offNamed(RoutesClass.getInicioRoute());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255,
                                    63,
                                    183,
                                    169), 
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
                            GestureDetector(
                              onTap: () {
                              //  Get.toNamed(RoutesClass.getRegisterRoute());
                              },
                              child: const Text(
                                "Olvidaste tu contraseña?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 63, 183,
                                      169), 
                                  decoration: TextDecoration
                                      .underline, 
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 80)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "No tienes una cuenta?",
                                  style: TextStyle(
                                    color: Colors
                                        .white30, // Color del texto para resaltar
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10)),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RoutesClass.getRegisterRoute());
                                  },
                                  child: const Text(
                                    "Registrarse",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 63, 183,
                                          169), // Color del texto para resaltar
                                      decoration: TextDecoration
                                          .underline, // Subrayado opcional
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.facebook,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    // URL de la página de Facebook
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 8)),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.twitter,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    // URL de la página de Facebook
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 8)),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.instagram,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    // URL de la página de Facebook
                                  },
                                ),
                              ],
                            )
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
      ),
    );
  }
}

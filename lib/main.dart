import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'firebase_options.dart'; // Importa las opciones de configuración de Firebase

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para operaciones asíncronas en el inicio
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inicializa Firebase con las opciones generadas
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesClass.getHomeRoute(), // Ruta inicial
      getPages: RoutesClass.routes, // Lista de rutas definidas
    );
  }
}

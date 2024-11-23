import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Configuración",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
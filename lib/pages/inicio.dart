import 'package:apsglam/controller/inicio_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InicioService());

    // ignore: unused_local_variable
    final InicioService service = Get.find<InicioService>();

    return Scaffold(
      backgroundColor: const Color(0xff120C24),
      appBar: AppBar(
        backgroundColor: const Color(0xff120C24),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "UPS GLAM",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(color: Colors.white, LineIcons.bell, size: 28),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return service.pages[service.selectedIndex.value];
        }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xff120C24),
        color: Colors.white70,
        animationDuration: const Duration(milliseconds: 250),
        height: 55,
        onTap: (index) {
          service.changePage(index);
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.black54,
            size: 25,
          ),
          Icon(
            Icons.add_a_photo,
            color: Colors.black54,
            size: 25,
          ),
          Icon(
            Icons.settings,
            color: Colors.black54,
            size: 25,
          ),
        ],
      ),
      );
    
  }
}

import 'package:apsglam/controller/inicio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final InicioService service = Get.find<InicioService>();

    return Obx(
      () {
        return ListView.builder(
            itemCount: service.myProfile.length,
            itemBuilder: (context, index) {
              final item = service.myProfile[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://w7.pngwing.com/pngs/733/160/png-transparent-computer-icons-upload-youtube-icon-upload-miscellaneous-photography-sign-thumbnail.png',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Text("Seguidores",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                                                Padding(padding:EdgeInsets.only(left: 15)),

                      Text("Likes",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                                                                        Padding(padding:EdgeInsets.only(left: 15)),

                      Text("Posts",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                        Padding(padding:EdgeInsets.only(left: 15)),
                    ],
                  )
                ],
              );
            });
      },
    );
  }
}

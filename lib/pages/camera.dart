import 'package:apsglam/controller/inicio_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  @override
  Widget build(BuildContext context) {
    final InicioService inicioService = Get.find<InicioService>();

    return Scaffold(
      backgroundColor: const Color(0xff120C24),
      body: Column(
        children: [
          Obx(() {
            if (inicioService.isCameraInitialized.value &&
                inicioService.cameraController != null &&
                inicioService.cameraController!.value.isInitialized) {
              return CameraPreview(inicioService.cameraController!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 65),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueAccent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.switch_camera),
                onPressed: () {
                  inicioService.switchCamera();
                },
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () async {
                  if (inicioService.cameraController != null &&
                      inicioService.cameraController!.value.isInitialized) {
                    // Captura la imagen
                    XFile image =
                        await inicioService.cameraController!.takePicture();
                    // Muestra un mensaje con la ruta de la imagen capturada
                    inicioService.subirImage(image);
                  }
                },
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () async {
                  inicioService.pickImageFromGallery();
                },
              ),
            ],
          ),
       ) )
  );}
}

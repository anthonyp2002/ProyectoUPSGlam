import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    // Obtiene la lista de cámaras disponibles en el dispositivo
    cameras = await availableCameras();

    if (cameras != null && cameras!.isNotEmpty) {
      // Inicializa la primera cámara disponible
      _cameraController = CameraController(
        cameras![0], // Puedes cambiar el índice para seleccionar la cámara trasera o frontal
        ResolutionPreset.high,
      );

      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    // Limpia el controlador de la cámara cuando se destruya la página
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Imagen'),
      ),
      body: _isCameraInitialized
          ? CameraPreview(_cameraController!)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_cameraController != null && _cameraController!.value.isInitialized) {
            // Captura la imagen
            XFile image = await _cameraController!.takePicture();
            // Aquí puedes hacer algo con la imagen capturada, como mostrarla o guardarla
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Imagen capturada: ${image.path}')),
            );
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}

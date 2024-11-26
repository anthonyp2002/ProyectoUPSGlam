import 'dart:convert';
import 'dart:io';
import 'package:apsglam/class/image_processor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apsglam/class/post.dart';
import 'package:apsglam/class/user.dart';
import 'package:apsglam/pages/camera.dart';
import 'package:apsglam/pages/homeinicio.dart';
import 'package:apsglam/pages/settings.dart';
import 'package:apsglam/routes/routes.dart';
import 'package:apsglam/services/firebase_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apsglam/class/data.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class InicioService extends GetxService {
  var stories = <Map<String, String>>[].obs;
  final RxList<DatosContenido> contenidoPage = <DatosContenido>[].obs;
  RxList<User> myProfile = <User>[].obs;
  RxList<Post> postsUser = <Post>[].obs;
  String baseUrl = 'http://172.16.219.153:5000';

  var imageProcesada = "".obs;
  File? imageSave;
  File? imagePost;
  final TextEditingController newComentario = TextEditingController();

  CameraController? cameraController;
  List<CameraDescription>? cameras;
  RxBool isCameraInitialized = false.obs;
  String id = "";
  int selectedCameraIndex = 0;
  final ImagePicker _imagePicker = ImagePicker();
  int meGusta =0;
  
  final ImageProcessor imageProcessor = ImageProcessor();
  String processedImageUrl = '';

  // Variables para los parámetros del filtro
  double brightness = 0.0;
  double saturation = 1.0;
  double kernelSize = 3.0;
  double reliefFactor = 2.0;
  int threadsPerBlock = 16;
  String selectedFilter = 'laplace';
  bool isProcessing = false;
  TextEditingController descripcionPost = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    stories.addAll([
      {
        'name': 'Juan',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      },
      {
        'name': 'Maria',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      },
      {
        'name': 'Carlos',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      },
      {
        'name': 'Luis',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      },
      {
        'name': 'Pedro',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      },
      {
        'name': 'Anthony',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'
      }
    ]);

    cargarDatosIniciales();
  }

    Future<void> refreshData() async {
      postsUser.clear();
      contenidoPage.clear();

      await Future.delayed(Duration(seconds: 2)); 
      getPostUser(id);

      getAllPosts().then((posts) {
        contenidoPage.value = posts;
      });


    }

  Future<void> cargarDatosIniciales() async {
    
    getAllPosts().then((posts) {
      contenidoPage.value = posts..shuffle();
    });

    myProfile = myUser;
    id = docuId;
    getPostUser(id);
  }

  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    const HomeInicio(),
    const CameraPage(),
    const Settings(),
  ];

  Future<void> initializeCamera() async {
    cameras = await availableCameras();

    if (cameras != null && cameras!.isNotEmpty) {
      cameraController = CameraController(
        cameras![selectedCameraIndex],
        ResolutionPreset.high,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
    }
  }

  void switchCamera() {
    if (cameras != null && cameras!.length > 1) {
      selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
      disposeCamera();
      initializeCamera();
    }
  }

  void getPostUser(String id) async {
    postsUser = await getPostsByUserId(id);
  }

  void disposeCamera() {
    cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
  }

  void subirImage(XFile image) {
    imageSave = File(image.path);
    Get.toNamed(RoutesClass.getEditRoute());
  }

  void subirPost(String imageG) async {
    File? imagePost;

    if (imageG == "camara") {
      imagePost = imageSave;
    } else if (imageG == "procesada") {
      imagePost = await downloadImage(imageProcesada.string);
    }

    if (imagePost != null) {
      String urlImg = await uploadImage(imagePost);

      Post postUser = Post(
          imgUrl: urlImg, descripcion: descripcionPost.text.isEmpty ? "" : descripcionPost.text, comentarios: [], likes: 0);

      savePost(postUser, id);

      descripcionPost.text = "";

      await refreshData();
      Get.back();
    } else {
      print("No se pudo descargar la imagen.");
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageSave = File(image.path);

      Get.toNamed(
        RoutesClass.getEditRoute(),
      );
    }
  }

  void changePage(int index) async {
    selectedIndex.value = index;
    if (index == 1) {
      await initializeCamera();
      
    } else if (cameraController != null) {
      disposeCamera();
    }
  }

  void addStory(String name, String imageUrl) {
    stories.add({'name': name, 'imageUrl': imageUrl});
  }

  void removeStory(int index) {
    stories.removeAt(index);
  }

  Future<void> applyServerFilter(String urlServe) async {
    isProcessing = true;
    final String imagePath;

    imagePath = imageSave!.path;

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(urlServe+'/upload'));
      var pic = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(pic);

      // Agregar parámetros adicionales
      request.fields['filter'] = selectedFilter;
      request.fields['kernel_size'] = kernelSize.toInt().toString();
      request.fields['relief_factor'] = reliefFactor.toString();
      request.fields['threads'] = threadsPerBlock.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        processedImageUrl = jsonResponse['filename'];
        isProcessing = false;


        imageProcesada.value =
            urlServe+'/images/$processedImageUrl';
      } else {
        isProcessing = false;

        Get.snackbar('Error', 'Error al procesar la imagen.');
      }
    } catch (e) {
      isProcessing = false;
      Get.snackbar('Error', 'No se pudo procesar la imagen: $e');
    }
  }

  Future<File?> downloadImage(String url) async {
    try {
      // Obtén la respuesta de la imagen desde la URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Obtén el directorio donde almacenar la imagen
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$processedImageUrl';
        File? file = File(filePath);

        // Escribe el contenido de la imagen en el archivo
        await file.writeAsBytes(response.bodyBytes);

        print('Imagen descargada y guardada en: $filePath');

        // Retorna el archivo guardado
        return file;
      } else {
        print('Error al descargar la imagen: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al descargar la imagen: $e');
      return null;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}

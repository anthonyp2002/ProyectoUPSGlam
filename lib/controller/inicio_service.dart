import 'package:apsglam/class/user.dart';
import 'package:apsglam/pages/camera.dart';
import 'package:apsglam/pages/homeinicio.dart';
import 'package:apsglam/pages/settings.dart';
import 'package:apsglam/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apsglam/class/data.dart'; 

class InicioService extends GetxService {  
  
  var stories = <Map<String, String>>[].obs;
  final RxList<DatosContenido> contenidoPage = <DatosContenido>[].obs;
  RxList<User> myProfile = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    stories.addAll([
      {'name': 'Juan', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'},
      {'name': 'Maria', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'},
      {'name': 'Carlos', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'},
      {'name': 'Luis', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'},
      {'name': 'Pedro', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'},
      {'name': 'Anthony', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s'}
    ]);

    contenidoPage.addAll([
      DatosContenido(
        imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKBYdyhrUsJQAl_UG692iP3LPFyPygKzAgjACWHvfpGxX-TxwHpnp3pWhrR84qTpucJ50&usqp=CAU",
        fecha: "2024-11-21",
        descripcion: "Otro contenido interesante.",
        comentarios: ["Genial", "Increíble"],
        likes: 50,
        name: "Juan Perez",
        profileImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s",
      ),

      DatosContenido(
        imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKBYdyhrUsJQAl_UG692iP3LPFyPygKzAgjACWHvfpGxX-TxwHpnp3pWhrR84qTpucJ50&usqp=CAU",
        fecha: "2024-11-21",
        descripcion: "Otro contenido interesante.",
        comentarios: ["No me gusta", "Que triste"],
        likes: 10,
        name: "María López",
        profileImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s",
      ),

      DatosContenido(
        imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKBYdyhrUsJQAl_UG692iP3LPFyPygKzAgjACWHvfpGxX-TxwHpnp3pWhrR84qTpucJ50&usqp=CAU",
        fecha: "2024-11-21",
        descripcion: "kandukasdbfhsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        comentarios: ["No me gusta", "Que triste"],
        likes: 10,
        name: "Anthony",
        profileImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhye46PoPBg7gcWsJjKrfDT98rIWdCZI6GA&s",
      ),
    ]);


    myProfile = myUser;
    print("El id de mi documento es $myProfile");
  }

  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    const HomeInicio(), 
    const CameraPage(),
    Settings(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void addStory(String name, String imageUrl) {
    stories.add({'name': name, 'imageUrl': imageUrl});
  }

  void removeStory(int index) {
    stories.removeAt(index);
  }

  @override
  void onClose() {
    super.onClose();
  }
}

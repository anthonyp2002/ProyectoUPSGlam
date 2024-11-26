import 'package:cloud_firestore/cloud_firestore.dart';

class DatosContenido {
  final String imgUrl;        
  final String descripcion; 
  final List<String> comentarios; 
  final int likes;           
  final String name;        
  final String profileImgUrl; 

  DatosContenido({
    required this.imgUrl,
    required this.descripcion,
    required this.comentarios,
    required this.likes,
    required this.name,
    required this.profileImgUrl,
  });

factory DatosContenido.fromDocument(DocumentSnapshot doc) {
  return DatosContenido(
    imgUrl: doc['imgUrl'] ?? '', 
    descripcion: doc['descripcion'] ?? '',
    comentarios: List<String>.from(doc['comentarios'] ?? []), 
    likes: doc['likes'] ?? 0,
    name:  '',
    profileImgUrl:  '',
  );
}

  // Método para actualizar campos específicos
  DatosContenido copyWith({String? name, String? profileImgUrl}) {
    return DatosContenido(
      imgUrl: imgUrl,
      descripcion: descripcion,
      comentarios: comentarios,
      likes: likes,
      name: name ?? this.name,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
    );
  }
}

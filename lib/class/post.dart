import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String imgUrl;       
  final String descripcion; 
  final List<String> comentarios; 
  final int likes;           

  Post({
    required this.imgUrl,
    required this.descripcion,
    required this.comentarios,
    required this.likes,
  });



factory Post.fromDocument(DocumentSnapshot doc) {
  return Post(
    imgUrl: doc['imgUrl'] ?? '', // Valor predeterminado si es nulo
    descripcion: doc['descripcion'] ?? '',
    comentarios: List<String>.from(doc['comentarios'] ?? []), // Conversión explícita
    likes: doc['likes'] ?? 0,
  );
}

}

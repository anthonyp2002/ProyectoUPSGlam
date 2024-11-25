import 'dart:io';

import 'package:apsglam/class/post.dart';
import 'package:apsglam/class/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
String docuId = "";
RxList<User> myUser = <User>[].obs;

Future<bool> verificarCredenciales(String name, String password) async {
  try {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('name', isEqualTo: name)
        .where('password', isEqualTo: password)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      docuId = userSnapshot.docs[0].id;

      for (var doc in userSnapshot.docs) {
        myUser.add(User.fromDocument(doc));
      }
      return true;
    }

    return false;
  } catch (e) {
    return false;
  }
}

Future<void> saveUser(User use) async {
  await db.collection("User").add({
    "name": use.name,
    "phone": use.telefono,
    "email": use.email,
    "password": use.password
  });
}

Future<String> uploadImage(File image) async {
  String namefile = image.path.split("/").last;
  final Reference ref = storage.ref().child("Post").child(namefile);
  final UploadTask uploadTask = ref.putFile(image);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  final String url = await snapshot.ref.getDownloadURL();

  return url;
}

Future<void> savePost(Post post, String id) async {
  await db.collection("User").doc(id).collection("Post").add({
    "imgUrl": post.imgUrl,
    "descripcion": post.descripcion,
    "comentarios": post.comentarios,
    'likes': post.likes
  });
}


Future<List<QueryDocumentSnapshot>> getAllPosts() async {
  List<QueryDocumentSnapshot> allPosts = [];

  try {
    QuerySnapshot userCollection = await FirebaseFirestore.instance.collection('User').get();

    // Recorre cada documento en 'User' para acceder a su subcolección 'Post'
    for (var userDoc in userCollection.docs) {
      // Obtén los documentos de la subcolección 'Post' de cada usuario
      QuerySnapshot postCollection = await userDoc.reference.collection('Post').get();

      // Agrega los documentos de 'Post' a la lista de todos los posts
      allPosts.addAll(postCollection.docs);
    }
  } catch (e) {
    print('Error al obtener los posts: $e');
  }

  return allPosts;
}

RxList<Post> getPostsByUserId(String userId) {
  RxList<Post> userPosts = <Post>[].obs;

  print("El id es $userId");
  FirebaseFirestore.instance
      .collection('User')
      .doc(userId)
      .collection('Post')
      .get()
      .then((QuerySnapshot postCollection) {
    // Mapeamos los documentos a objetos Post y los agregamos a la lista observada
    userPosts.addAll(postCollection.docs.map((doc) => Post.fromDocument(doc)).toList());
  }).catchError((e) {
    print('Error al obtener los posts para el usuario $userId: $e');
  });

  return userPosts;
}


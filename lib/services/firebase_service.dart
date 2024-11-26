import 'dart:io';

import 'package:apsglam/class/data.dart';
import 'package:apsglam/class/post.dart';
import 'package:apsglam/class/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
String docuId = "";
RxList<User> myUser = <User>[].obs;

Future<bool> verificarCredenciales(String email, String password) async {
  try {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
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

  await verificarCredenciales(use.email,use.password);
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


Future<List<DatosContenido>> getAllPosts() async {
  List<DatosContenido> allPosts = [];

  try {
    QuerySnapshot userCollection = await FirebaseFirestore.instance.collection('User').get();

    for (var userDoc in userCollection.docs) {
      // Obtén los datos del usuario
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String userName = userData['name'] ?? 'Desconocido'; // Campo "name" del usuario
      String userProfileImgUrl = userData['profileImgUrl'] ?? ''; // Campo "profileImgUrl" del usuario

      QuerySnapshot postCollection = await userDoc.reference.collection('Post').get();

      for (var postDoc in postCollection.docs) {
        // Construye el objeto DatosContenido
        DatosContenido post = DatosContenido.fromDocument(postDoc)
            .copyWith(name: userName, profileImgUrl: userProfileImgUrl);
        allPosts.add(post);
      }
    }
  } catch (e) {
    print('Error al obtener los posts: $e');
  }

  return allPosts;
}


Future<void> editCommentsByImgUrl(BuildContext context,String imgUrl, List<String> newComments) async {
  try {
    // Obtén todas las colecciones de usuarios
    QuerySnapshot userCollection =
        await FirebaseFirestore.instance.collection('User').get();

    // Recorre cada documento de usuario
    for (var userDoc in userCollection.docs) {
      // Accede a la subcolección "Post" del usuario
      QuerySnapshot postCollection = await userDoc.reference
          .collection("Post")
          .where("imgUrl", isEqualTo: imgUrl)
          .get();

      // Actualiza los comentarios de los posts que coincidan con el imgUrl
      for (var postDoc in postCollection.docs) {
        await postDoc.reference.update({
          "comentarios": newComments,
        });
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comentarios guardado con exito.')),
      );
  } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error.')),
      );
  }
}

Future<void> editLikesByImgUrl(String imgUrl, int newLikeCount) async {
  try {
    // Obtén todas las colecciones de usuarios
    QuerySnapshot userCollection =
        await FirebaseFirestore.instance.collection('User').get();

    // Recorre cada documento de usuario
    for (var userDoc in userCollection.docs) {
      // Accede a la subcolección "Post" del usuario
      QuerySnapshot postCollection = await userDoc.reference
          .collection("Post")
          .where("imgUrl", isEqualTo: imgUrl)
          .get();

      // Actualiza los likes de los posts que coincidan con el imgUrl
      for (var postDoc in postCollection.docs) {
        await postDoc.reference.update({
          "likes": newLikeCount,
        });
      }
    }
    print("Likes actualizados con éxito.");
  } catch (e) {
    print("Error al actualizar los likes: $e");
  }
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


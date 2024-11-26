import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;       
  final String telefono;       
  final String email; 
  final String password;      
  final String profileImgUrl;      
   

  User({
    required this.name,
    required this.telefono,
    required this.email,
    required this.password,
    required this.profileImgUrl,

  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        name: doc['name'],
        telefono: doc["phone"],
        password: doc["password"],
        email: doc['email'],
        profileImgUrl: doc['profileImgUrl'],
   );
  }
}

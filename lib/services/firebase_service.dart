import 'package:apsglam/class/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
String docuId ="" ;
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

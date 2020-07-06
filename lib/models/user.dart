import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.id});

  User.fromDocument(DocumentSnapshot doc) {
    userName = doc.data['name'] as String;
    email = doc.data['email'] as String;
  }

  String id;
  String userName;
  String email;
  String password;

  

  DocumentReference get firestoreReference =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference =>
    firestoreReference.collection('cart');

  Future<void> saveData() async {
    await firestoreReference.setData({
      'name': userName,
      'email': email,
    });
  }
}

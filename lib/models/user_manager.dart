import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:flutter/foundation.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  User user;

  bool get isLogged => user != null;

  UserManager() {
    _loadCurrentUser();
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await Future.delayed(Duration(seconds: 1));
      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      await Future.delayed(Duration(seconds: 1));
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      await Future.delayed(Duration(seconds: 1));
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }


  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser = await Firestore.instance
          .collection('users')
          .document(currentUser.uid)
          .get();
      user = User.fromDocument(docUser);
      notifyListeners();
    }
  }
}

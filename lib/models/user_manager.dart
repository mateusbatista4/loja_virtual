import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  FirebaseUser user;

  UserManager() {
    _loadCurrentUser();
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      this.user = result.user;
      await Future.delayed(Duration(seconds: 1));
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

  Future<void> _loadCurrentUser() async {
    FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
      notifyListeners();
    }
  }
}

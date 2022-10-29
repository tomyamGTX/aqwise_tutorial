import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  //listen user exist or not
  AuthProvider._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  //call current user
  User? get user => FirebaseAuth.instance.currentUser;

  factory AuthProvider() => AuthProvider._();

  static AuthProvider get instance => AuthProvider();

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}

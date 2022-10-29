import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  User? get user => FirebaseAuth.instance.currentUser;

  factory AuthProvider() => AuthProvider._();

  static AuthProvider get instance => AuthProvider();
}

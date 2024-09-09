import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth getFirebaseAuth() {
    return _firebaseAuth; //firebaseauth is the entry point of firebase authntication sdk
  }

  Future<String> currentUserUId() async {
    User? user = await _firebaseAuth.currentUser;
    return user!.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email!, password: password!);
    User? user = userCredential.user;
    return user!.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      {String? email, String? password}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!);
    User? user = userCredential.user;
    return user!.uid;
  }

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    return user!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    return user!.emailVerified;
  }
}

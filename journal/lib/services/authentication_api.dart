import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationApi {
  FirebaseAuth getFirebaseAuth();
  Future<String> currentUserUId();
  Future<void> signOut();
  Future<String> signInWithEmailAndPassword({String email, String password});
  Future<String> createUserWithEmailAndPassword(
      {String email, String password});
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}

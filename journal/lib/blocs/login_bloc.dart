import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:journal/classes/validator.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/services/authentication_api.dart';

class LoginBloc extends Validator {
  final AuthenticationApi authenticationApi;
  String? _email;
  String? _password;
  bool _emailValid = false;
  bool _passwordValid = false;

  final StreamController<String> _emailController =
      StreamController<String>.broadcast();
  Sink<String> get emailChanged => _emailController.sink;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();
  Sink<String> get passwordChanged => _passwordController.sink;
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  final StreamController<bool> _enableLoginCreateButtonController =
      StreamController<bool>.broadcast();
  Sink<bool> get enableLoginCreateButtonChanged =>
      _enableLoginCreateButtonController.sink;
  Stream<bool> get enableLoginCreateButton =>
      _enableLoginCreateButtonController.stream;

  final StreamController<String> _loginOrCreateButtonController =
      StreamController<String>.broadcast();
  Sink<String> get loginOrCreateButtonChanged =>
      _loginOrCreateButtonController.sink;
  Stream<String> get loginOrCreateButton =>
      _loginOrCreateButtonController.stream;

  final StreamController<String> _loginOrCreateController =
      StreamController<String>.broadcast();
  Sink<String> get loginOrCreateChanged => _loginOrCreateController.sink;
  Stream<String> get loginOrCreate => _loginOrCreateController.stream;

  LoginBloc(this.authenticationApi) {
    _startListnersIfLoginPasswordAreValid();
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _enableLoginCreateButtonController.close();
    _loginOrCreateButtonController.close();
    _loginOrCreateController.close();
  }

  void _startListnersIfLoginPasswordAreValid() {
    email.listen((email) {
      _email = email;
      _emailValid = true;
      _updateEnableEmailLoginCreateButtonStream();
    }).onError((error) {
      _email = '';
      _emailValid = false;
      _updateEnableEmailLoginCreateButtonStream();
    });
    password.listen((password) {
      _password = password;
      _passwordValid = true;
      _updateEnableEmailLoginCreateButtonStream();
    }).onError((error) {
      _password = '';
      _passwordValid = false;
      _updateEnableEmailLoginCreateButtonStream();
    });
  }

  void _updateEnableEmailLoginCreateButtonStream() {
    if (_emailValid == true && _passwordValid == true) {
      print('Email and password are valid: enabling button');
      _enableLoginCreateButtonController.add(true);
    } else if (_emailValid == false && _passwordValid == false) {
      print('Email or password are invalid: disabling button');
      _enableLoginCreateButtonController.add(false);
    }
  }

  Future<String> logIn() async {
    String result = await _logIn();
    print('Log in result: $result');
    return result;
  }

  Future<String> _logIn() async {
    String result = '';
    if (_emailValid == true && _passwordValid == true) {
      result = await authenticationApi.signInWithEmailAndPassword(
          email: _email!, password: _password!);

      if (result != 'No user found for that email.' &&
          result != 'Wrong password provided for that user.' &&
          !result.startsWith('Error')) {
        // If result is a valid UID, consider it a success
        print('Log in success with UID: $result');
        return 'success';
      } else {
        // Otherwise, return the error message
        print('Log in error: $result');
        return result;
      }
    } else {
      return "Email and password are not valid";
    }
  }

  Future<String> createAccount() async {
    String result = await _createAccount();
    return result;
  }

  Future<String> _createAccount() async {
    String result = '';
    if (_emailValid == true && _passwordValid == true) {
      try {
        String uid = await authenticationApi.createUserWithEmailAndPassword(
            email: _email!, password: _password!);
        print("Created User UID: $uid");
        await authenticationApi.signInWithEmailAndPassword(
            email: _email!, password: _password!);
        result = 'success';
      } catch (error) {
        print('Create Account error $error');
        result = 'error';
      }
    } else {
      result = 'Email and password are not valid';
    }
    return result;
  }
}

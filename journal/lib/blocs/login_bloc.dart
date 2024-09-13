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
  Stream<String> get password => _passwordController.stream;

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
      _enableLoginCreateButtonController.add(true);
    } else {
      _enableLoginCreateButtonController.add(false);
    }
  }

  Future<String> _logIn() async {
    String _result = '';
    if (_emailValid == true && _passwordValid == true) {
      await authenticationApi
          .signInWithEmailAndPassword(email: _email!, password: _password!)
          .then((User) {
        _result = 'success';
      }).catchError((error) {
        print("Login Error $error");
        _result = 'error';
      });
      return _result;
    } else {
      return "Email and password are not valid";
    }
  }

  Future<String> _createAccount() async {
    String _result = '';
    if (_emailValid == true && _passwordValid == true) {
      await authenticationApi
          .createUserWithEmailAndPassword(email: _email!, password: _password!)
          .then((User) {
        print("Created User $User");
        authenticationApi
            .signInWithEmailAndPassword(email: _email!, password: _password!)
            .then((User) {
          print("Logged in $User");
        }).catchError((error) {
          print('LOgin error $error');
        }).catchError((error) {
          print('Create Account error $error');
        });
      });
      return _result;
    } else {
      return 'Error creating User';
    }
  }
}

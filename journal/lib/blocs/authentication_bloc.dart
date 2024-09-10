import 'dart:async';
import 'package:flutter/material.dart';
import 'package:journal/services/authentication_api.dart';

class AuthenticationBloc {
  final AuthenticationApi _authenticationApi;
  final StreamController<String> _authenticationController =
      StreamController<String>();
  Sink<String> get addUser => _authenticationController.sink;
  Stream<String> get User => _authenticationController.stream;

  final StreamController<String> _logOutController = StreamController<String>();
  Sink<String> get logOutUser => _logOutController.sink;
  Stream<String> get listLogOutUser => _logOutController.stream;

  AuthenticationBloc(this._authenticationApi) {
    onAuthChange();
  }
  void dispose() {
    _authenticationController.close();
    _logOutController.close();
  }

  void onAuthChange() {
    _authenticationApi.getFirebaseAuth().onAuthChange.listen((User) {
      final String uid = User != null ? User.uid : null;
      addUser.add(uid);
    });
    _logOutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }

  void _signOut() {
    _authenticationApi.signOut();
  }
}

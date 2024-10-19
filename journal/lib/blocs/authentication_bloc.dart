import 'dart:async';
import 'package:journal/services/authentication_api.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationBloc {
  final AuthenticationApi _authenticationApi;

  final StreamController<String> _authenticationController =
      StreamController<String>();
  Sink<String> get addUser => _authenticationController.sink;
  Stream<String> get User => _authenticationController.stream;

  final StreamController<String> _logOutController = StreamController<String>();
  Sink<String> get logOutUser => _logOutController.sink;
  Stream<String> get listLogOutUser => _logOutController.stream;

  late final StreamSubscription _authStateSubscription;
  late final StreamSubscription _logOutSubscription;

  // Constructor
  AuthenticationBloc(this._authenticationApi) {
    _authStateSubscription = _authenticationApi
        .getFirebaseAuth()
        .authStateChanges()
        .listen((firebase_auth.User? user) {
      if (user != null) {
        final String uid = user.uid;
        addUser.add(uid);
      } else {
        addUser.add('signed_out');
      }
    });

    // Listen for logout events and trigger the sign out
    _logOutSubscription = _logOutController.stream.listen((shouldLogOut) {
      if (shouldLogOut == true) {
        _signOut();
      }
    });
  }

  // Dispose method to close the controllers and cancel subscriptions
  void dispose() {
    _authenticationController.close();
    _logOutController.close();
    _authStateSubscription.cancel();
    _logOutSubscription.cancel();
  }

  // Sign-out function
  void _signOut() {
    _authenticationApi.signOut();
  }
}

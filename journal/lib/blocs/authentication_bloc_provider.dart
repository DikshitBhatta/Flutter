import 'package:flutter/material.dart';
import 'authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;
  AuthenticationBlocProvider({
    Key? key,
    Widget? child,
    required this.authenticationBloc,
  }) : super(key: key, child: child!);

  static AuthenticationBlocProvider of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<AuthenticationBlocProvider>()
        as AuthenticationBlocProvider);
  }

  @override
  bool updateShouldNotify(AuthenticationBlocProvider oldWidget) =>
      authenticationBloc != oldWidget.authenticationBloc;
}

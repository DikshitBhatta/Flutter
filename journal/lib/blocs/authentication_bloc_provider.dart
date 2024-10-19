import 'package:flutter/material.dart';
import 'authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;
  AuthenticationBlocProvider({
    super.key,
    Widget? child,
    required this.authenticationBloc,
  }) : super(child: child!);

  static AuthenticationBlocProvider of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<AuthenticationBlocProvider>()
        as AuthenticationBlocProvider);
  }

  @override
  bool updateShouldNotify(AuthenticationBlocProvider oldWidget) =>
      authenticationBloc != oldWidget.authenticationBloc;
}

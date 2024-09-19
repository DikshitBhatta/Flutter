import 'package:flutter/material.dart';
import 'package:journal/blocs/homebloc.dart';

class Homeblocprovider extends InheritedWidget {
  final Homebloc homebloc;
  final String uid;
  const Homeblocprovider(
      {Key? key,
      required Widget child,
      required this.homebloc,
      required this.uid})
      : super(key: key, child: child);
  static Homeblocprovider of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<Homeblocprovider>()
        as Homeblocprovider);
  }

  @override
  bool updateShouldNotify(Homeblocprovider oldWidget) =>
      homebloc != oldWidget.homebloc || uid != oldWidget.uid;
}

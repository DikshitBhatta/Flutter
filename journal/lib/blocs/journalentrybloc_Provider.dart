import 'package:flutter/material.dart';
import 'package:journal/blocs/journalentry_bloc.dart';

class JournalentryblocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  const JournalentryblocProvider(
      {super.key, required super.child, required this.journalEditBloc});

  static JournalentryblocProvider of(BuildContext context) {
    return (context
            .getElementForInheritedWidgetOfExactType<JournalentryblocProvider>()
        as JournalentryblocProvider);
  }

  @override
  bool updateShouldNotify(JournalentryblocProvider oldWidget) => false;
}

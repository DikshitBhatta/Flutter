import 'package:flutter/material.dart';
import 'package:journal/blocs/journalentry_bloc.dart';

class JournalentryblocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  const JournalentryblocProvider(Key? key, Widget child, this.journalEditBloc)
      : super(key: key, child: child);

  JournalentryblocProvider of(BuildContext context) {
    return (context
            .getElementForInheritedWidgetOfExactType<JournalentryblocProvider>()
        as JournalentryblocProvider);
  }

  @override
  bool updateShouldNotify(JournalentryblocProvider oldWidget) => false;
}

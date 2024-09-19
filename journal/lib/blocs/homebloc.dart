import 'dart:async';
import 'package:journal/services/authentication_api.dart';
import 'package:journal/services/db_firestoreapi.dart';
import 'package:journal/model/journal.dart';

class Homebloc {
  final DbApi dbApi;
  final AuthenticationApi authenticationApi;
  final StreamController<List<Journal>> _journalController =
      StreamController<List<Journal>>.broadcast();
  Sink<List<Journal>> get _addListJournal => _journalController.sink;
  Stream<List<Journal>> get listJournal => _journalController.stream;

  final StreamController<List<Journal>> _journalDeleteController =
      StreamController<List<Journal>>.broadcast();
  Sink<List<Journal>> get deleteJournal => _journalDeleteController.sink;

  Homebloc(this.authenticationApi, this.dbApi) {
    _startListner();
  }
  void dispose() {
    _journalController.close();
    _journalDeleteController.close();
  }

  void _startListner() {
    var user = authenticationApi.getFirebaseAuth().currentUser;
    if (user != null) {
      dbApi.getJournalList(user.uid).listen((journalDocs) {
        print("Received journal data: ${journalDocs.length} entries");
        _addListJournal.add(journalDocs);
      });
      _journalDeleteController.stream.listen((journalList) {
        for (var journal in journalList) {
          dbApi.deleteJournal(journal);
        }
      });
    } else {
      print("No user is currently signed in.");
    }
  }
}

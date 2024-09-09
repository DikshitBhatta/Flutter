import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal/model/journal.dart';
import 'db_firestoreapi.dart';

class DbFirestoreServices implements DbApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _collectionJournal = 'jounals';

  Stream<List<Journal>> getJournalList(String uid) {
    return firestore
        .collection(_collectionJournal)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Journal> _journaldocs =
          snapshot.docs.map((doc) => Journal.fromDoc(doc)).toList();
      _journaldocs.sort((comp1, comp2) => (comp2.date!.compareTo(comp1.date!)));
      return _journaldocs;
    });
  }

  Future<Journal> getJournal(String documentId) async {
    DocumentSnapshot
        _documentSnapshot = //represent snapshot of documebt in database
        await firestore.collection(_collectionJournal).doc(documentId).get();
    return Journal.fromDoc(_documentSnapshot);
  }

  Future<bool> addJournal(Journal journal) async {
    DocumentReference _documentRefrence =
        await firestore.collection(_collectionJournal).add({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
      'uid': journal.uid
    });
    return _documentRefrence.id != null;
  }

  void updateJournal(Journal journal) async {
    await firestore
        .collection(_collectionJournal)
        .doc(journal.documentId)
        .update({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
    }).catchError((error) => print('ErrorUpdating $error'));
  }

  void updateJournalWithTransaction(Journal journal) async {
    await firestore.runTransaction((Transaction) async {
      DocumentReference _documentRefrence =
          firestore.collection(_collectionJournal).doc(journal.documentId);
      DocumentSnapshot docSnapshot = await Transaction.get(_documentRefrence);
      Transaction.update(_documentRefrence, {
        'date': journal.date,
        'mood': journal.mood,
        'note': journal.note,
      });
    });
  }

  void deleteJournal(Journal journal) async {
    firestore
        .collection(_collectionJournal)
        .doc(journal.documentId)
        .delete()
        .catchError((error) => print('Error deleting $error'));
  }
}

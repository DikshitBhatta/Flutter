import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal/model/journal.dart';
import 'db_firestoreapi.dart';

class DbFirestoreServices implements DbApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionJournal = 'journals';

  @override
  Stream<List<Journal>> getJournalList(String uid) {
    return firestore
        .collection(_collectionJournal)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Journal> journaldocs =
          snapshot.docs.map((doc) => Journal.fromDoc(doc)).toList();
      journaldocs.sort((comp1, comp2) => (comp2.date!.compareTo(comp1.date!)));
      return journaldocs;
    });
  }

  @override
  Future<Journal> getJournal(String documentId) async {
    DocumentSnapshot
        documentSnapshot = //represent snapshot of documebt in database
        await firestore.collection(_collectionJournal).doc(documentId).get();
    return Journal.fromDoc(documentSnapshot);
  }

  @override
  Future<bool> addJournal(Journal journal) async {
    DocumentReference documentRefrence =
        await firestore.collection(_collectionJournal).add({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
      'uid': journal.uid
    });
    return documentRefrence.id != null;
  }

  @override
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

  @override
  void updateJournalWithTransaction(Journal journal) async {
    await firestore.runTransaction((Transaction) async {
      DocumentReference documentRefrence =
          firestore.collection(_collectionJournal).doc(journal.documentId);
      DocumentSnapshot docSnapshot = await Transaction.get(documentRefrence);
      if (!docSnapshot.exists) {
        throw Exception("Document does not exist!");
      }
      Transaction.update(documentRefrence, {
        'date': journal.date,
        'mood': journal.mood,
        'note': journal.note,
      });
    }).catchError((error) => print('Transaction error: $error'));
  }

  @override
  void deleteJournal(Journal journal) async {
    firestore
        .collection(_collectionJournal)
        .doc(journal.documentId)
        .delete()
        .catchError((error) => print('Error deleting $error'));
  }
}

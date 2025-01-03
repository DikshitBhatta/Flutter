class Journal {
  String? documentId;
  String? date;
  String? mood;
  String? note;
  String? uid;

  Journal({this.documentId, this.date, this.mood, this.note, this.uid});

  factory Journal.fromDoc(dynamic doc) => Journal(
      //conveting adn mapping cloud firestore database document record
      documentId: doc.id,
      date: doc['date'],
      mood: doc['mood'],
      note: doc['note'],
      uid: doc['uid']);
}

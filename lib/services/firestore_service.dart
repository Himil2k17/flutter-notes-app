import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser!;

  CollectionReference get _notesRef =>
      _firestore.collection('users').doc(_user.uid).collection('notes');

  Future<void> addNote(String content) async {
    await _notesRef.add({
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getNotes() {
    return _notesRef.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> deleteNote(String id) async {
    await _notesRef.doc(id).delete();
  }
}

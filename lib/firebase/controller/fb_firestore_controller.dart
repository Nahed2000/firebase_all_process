import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_all_process/model/notes.dart';

class FbFireStoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //CRUD

  //Create
  Future<bool> create({required Notes notes}) async {
    return await _firebaseFirestore
        .collection('Notes')
        .add(notes.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }

  // Delete
  Future<bool> delete({required String path}) async {
    return _firebaseFirestore
        .collection('Notes')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((onError) => false);
  }

  //Update
  Future<bool> update({required Notes notes}) async {
    return _firebaseFirestore
        .collection('Notes')
        .doc(notes.id)
        .update(notes.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }

//Read
  Stream<QuerySnapshot<Notes>> read() async* {
    yield* _firebaseFirestore
        .collection('Notes')
        .withConverter<Notes>(
            fromFirestore: (snapshot, options) =>
                Notes.fromMap(snapshot.data()!),
            toFirestore: (value, options) => value.toMap())
        .snapshots();
  }
}

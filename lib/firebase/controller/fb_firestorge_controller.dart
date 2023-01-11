import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageController {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  UploadTask create({required File file}) {
    return firebaseStorage
        .ref('images/${DateTime.now().millisecondsSinceEpoch}')
        .putFile(file);
  }

  Future<bool> delete({required String path}) {
    return firebaseStorage
        .ref(path)
        .delete()
        .then((value) => true)
        .catchError((onError) => false);
  }

  Future<List<Reference>> read() async {
    ListResult listResult = await firebaseStorage.ref('images').listAll();
    if (listResult.items.isNotEmpty) {
      return listResult.items;
    }
    return [];
  }
}

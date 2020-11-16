import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirUploadPhoto {
  final FirebaseStorage _firebaseStorage;

  FirUploadPhoto(this._firebaseStorage);

  Future<void> uploadFile(String filePath, Function(String urlPath) onSuccess, Function onError) async {
    File file = File(filePath);
    Reference storageReference = _firebaseStorage
        .ref('images/${path.basename(filePath)}');
    try {
      await storageReference.putFile(file);
    } on FirebaseException catch (e) {
      onError();
    }
    storageReference.getDownloadURL().then((fileURL) {
      onSuccess(fileURL);
    });
  }

  Future<void> uploadVideo(String filePath, Function(String urlPath) onSuccess, Function onError) async {
    File file = File(filePath);
    Reference storageReference = _firebaseStorage
        .ref('videos/${Random.secure().nextDouble()}.mp4');
    try {
      await storageReference.putFile(file);
    } on FirebaseException catch (e) {
      onError();
    }
    storageReference.getDownloadURL().then((fileURL) {
      onSuccess(fileURL);
    });
  }
}

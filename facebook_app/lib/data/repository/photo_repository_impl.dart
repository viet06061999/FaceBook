import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/source/remote/fire_base_storage.dart';
import 'package:rxdart/rxdart.dart';

 class PhotoRepositoryImpl extends PhotoRepository {
   FirUploadPhoto firPhoto;

   PhotoRepositoryImpl(this.firPhoto);
  @override
  Future<void> uploadPhoto(String filePath, Function(String urlPath) onSuccess, Function onError) =>
      firPhoto.uploadFile(filePath, onSuccess, onError);
}

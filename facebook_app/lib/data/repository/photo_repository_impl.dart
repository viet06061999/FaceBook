import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/source/remote/fire_base_storage.dart';

 class PhotoRepositoryImpl extends PhotoRepository {
   FirUploadPhoto firPhoto;

   PhotoRepositoryImpl(this.firPhoto);
  @override
  Future<void> uploadPhoto(String filePath, Function(String urlPath) onSuccess, Function onError) =>
      firPhoto.uploadFile(filePath, onSuccess, onError);

   @override
   Future<void> uploadVideo(String filePath, Function(String urlPath) onSuccess, Function onError) =>
       firPhoto.uploadVideo(filePath, onSuccess, onError);
}

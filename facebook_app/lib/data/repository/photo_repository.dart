import 'package:facebook_app/data/model/video.dart';
import 'package:rxdart/rxdart.dart';

abstract class PhotoRepository{
  Future<void> uploadPhoto(String idOwner, String filePath,
      Function(String) onSuccess, Function onError, Function(double) onProgress);

  Future<void> uploadVideo(String idOwner, String filePath,
      Function(String) onSuccess, Function onError, Function(double) onProgress);

  Stream<List<String>> getImagesByUser(String userId);

  Stream<List<Video>> getVideosByUser(String userId);
}

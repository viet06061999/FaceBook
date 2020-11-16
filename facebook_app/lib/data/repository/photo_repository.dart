abstract class PhotoRepository {
  Future<void> uploadPhoto(
      String filePath, Function(String) onSuccess, Function onError);

  Future<void> uploadVideo(
      String filePath, Function(String) onSuccess, Function onError);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:rxdart/rxdart.dart';

class FirUserUpload {
  final FirebaseFirestore _firestore;

  FirUserUpload(this._firestore);

  Observable<void> uploadImage(String idOwner, String url) {
    Future<void> future = _firestore
        .collection("images")
        .add({"id_owner": idOwner, "image_url": url});
    return Observable.fromFuture(future);
  }

  Observable<void> uploadVideo(String idOwner, Video video) {
    Future<void> future = _firestore.collection("videos").add({
      "id_owner": idOwner,
      "video": video.toMap()
    });
    return Observable.fromFuture(future);
  }
}

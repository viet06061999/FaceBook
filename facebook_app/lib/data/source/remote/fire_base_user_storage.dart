import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:rxdart/rxdart.dart';

class FirUserUpload {
  final FirebaseFirestore _firestore;

  FirUserUpload(this._firestore);

  Observable<void> uploadImage(String idOwner, String url) {
    Future<void> future = _firestore.collection("images").doc(idOwner).update({
      'my_images': FieldValue.arrayUnion([url])
    }).catchError((onError) => {print('loi o day $onError')});
    return Observable.fromFuture(future);
  }

  Observable<void> uploadVideo(String idOwner, Video video) {
    Future<void> future = _firestore.collection("videos").doc(idOwner).update({
      'my_videos': FieldValue.arrayUnion([video.toMap()])
    });
    return Observable.fromFuture(future);
  }

  Observable<DocumentSnapshot> getImagesByUserId(String userId) {
    print('userid $userId');
    return Observable.fromFuture(
        _firestore.collection("images").doc(userId).get());
  }

  Observable<DocumentSnapshot> getVideos(String userId) {
    return Observable.fromFuture(
        _firestore.collection("videos").doc(userId).get());
  }
}

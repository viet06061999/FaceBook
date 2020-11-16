import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

class FirPost {
  final FirebaseFirestore _firestore;

  FirPost(this._firestore);

  Observable<void> createPost(Post post) {
    Future<void> future =
        _firestore.collection("posts").add(post.postToMap()).then((value) {
      value.update({"post_id": value.id});
    });
    return Observable.fromFuture(future);
  }

  Observable<void> updatePost(Post post) {
    Future<void> future = _firestore
        .collection("posts")
        .doc(post.postId)
        .update(post.postToMap());

    return Observable.fromFuture(future);
  }

  Stream<QuerySnapshot> getListPost() =>
      _firestore.collection('posts').snapshots(includeMetadataChanges: true);
}

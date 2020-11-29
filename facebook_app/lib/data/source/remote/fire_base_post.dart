import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

class FirPost {
  final FirebaseFirestore _firestore;

  FirPost(this._firestore);

  Observable<void> createPost(Post post, String userId) {
    Future<void> future = _firestore
        .collection("posts")
        .add(post.postToMap(_firestore.doc('users/' + userId)))
        .then((value) {
      value.update({"post_id": value.id});
    });
    return Observable.fromFuture(future);
  }

  Observable<void> updatePost(Post post, String userId) {
    Future<void> future = _firestore
        .collection("posts")
        .doc(post.postId)
        .update(post.postToMap(_firestore.doc('users/' + userId)));
    return Observable.fromFuture(future);
  }

  Stream<QuerySnapshot> getListPost() => _firestore
      .collection('posts')
      .snapshots(includeMetadataChanges: true);

  Stream<QuerySnapshot> getUserListPost(String userId) {
    var doc = _firestore.collection('users').doc(userId);
    return _firestore
        .collection('posts')
        .where('owner', isEqualTo: doc)
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> getPostsWithVideo() =>
      _firestore.collection('posts').where('videos',
          isNotEqualTo: []).snapshots(includeMetadataChanges: true);

  Stream<QuerySnapshot> getMyPost(String id){
    return _firestore
        .collection('posts')
        .where('id', isEqualTo: id)
        .snapshots(includeMetadataChanges: true);
  }
}

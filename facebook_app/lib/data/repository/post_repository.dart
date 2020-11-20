import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostRepository {
  Observable<void> createPost(Post post, String userId);

  Observable<void> updatePost(Post post, String userId);

  Stream<QuerySnapshot> getListPost();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostRepository {
  Observable<void> createPost(Post post, String userId);

  Observable<void> updatePost(Post post, String userId);

  Observable<void> updateLikePost(Post post, UserEntity userEntity);

  Observable<void> updateDisLikePost(Post post, UserEntity userEntity);

  Observable<void> updateComment(Post post, Comment comment);

  Stream<QuerySnapshot> getListPost();

  Stream<QuerySnapshot> getUserListPost(String userId);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostRepository {
  Observable<DocumentReference> createPost(Post post);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/source/remote/fire_base_post.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:rxdart/rxdart.dart';

class PostRepositoryImpl implements PostRepository {
  final FirPost _firPost;
  final SpUtil _spUtil;

  PostRepositoryImpl(this._firPost, this._spUtil);

  @override
  Observable<void> createPost(Post post) => _firPost.createPost(post);

  @override
  Stream<QuerySnapshot> getListPost() => _firPost.getListPost();

  @override
  Observable<void> updatePost(Post post) => _firPost.updatePost(post);
}

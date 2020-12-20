import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/source/remote/fire_base_notification.dart';
import 'package:facebook_app/data/source/remote/fire_base_post.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:rxdart/rxdart.dart';

class PostRepositoryImpl implements PostRepository {
  final FirPost _firPost;
  final SpUtil _spUtil;
  final FirNotification _firNotification;

  PostRepositoryImpl(this._firPost, this._spUtil, this._firNotification);

  @override
  Observable<void> createPost(Post post, String userId) =>
      _firPost.createPost(post, userId);

  @override
  Stream<QuerySnapshot> getListPost() => _firPost.getListPost();

  @override
  Stream<QuerySnapshot> getUserListPost(String userId) =>
      _firPost.getUserListPost(userId);

  @override
  Observable<void> updatePost(Post post, String userId) =>
      _firPost.updatePost(post, userId);

  @override
  Observable<void> updateComment(Post post, Comment comment) {
    if (post.owner.id != comment.user.id) {
      _firNotification.updateNotificationCommentPost(post, comment);
    }
    return _firPost.updatePost(post, post.owner.id);
  }

  @override
  Observable<void> updateDisLikePost(Post post, UserEntity userEntity) {
    if (post.owner.id != userEntity.id) {
      _firNotification.updateNotificationDisLikePost(post, userEntity);
    }
    return _firPost.updatePost(post, post.owner.id);
  }

  @override
  Observable<void> updateLikePost(Post post, UserEntity userEntity) {
    if (post.owner.id != userEntity.id) {
      _firNotification.updateNotificationLikePost(post, userEntity);
    }
    return _firPost.updatePost(post, post.owner.id);
  }
}

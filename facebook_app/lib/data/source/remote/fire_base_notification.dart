import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';

class FirNotification {
  final FirebaseFirestore _firestore;

  FirNotification(this._firestore);

  Future<void> createNotificationFriend(
      Notification notification, String idUserFirst) {
    return _firestore
        .collection('notification')
        .add(notification.toMap(_firestore.doc('users/' + idUserFirst)));
  }

  Future<void> updateNotificationPost(
      NotificationPost notification, Post post, String idUserFirst,
      {String idUserSecond}) async {
    var ref =
        await _firestore.collection('notification').doc(post.postId).get();
    Future<void> future = null;
    if (ref.exists) {
      future = _firestore.collection('notification').doc(post.postId).update(
          notification.toMap(_firestore.doc('users/' + idUserFirst),
              userSecond: _firestore.doc('users/' + idUserFirst),
              post: _firestore.doc('posts/' + post.postId)));
    } else {
      future = _firestore.collection('notification').doc(post.postId).set(
          notification.toMap(_firestore.doc('users/' + idUserFirst),
              userSecond: _firestore.doc('users/' + idUserFirst),
              post: _firestore.doc('posts/' + post.postId)));
    }
    return future;
  }

  Stream<QuerySnapshot> getNotifications(String userId) => _firestore
      .collection('notification')
      .where('recivers', arrayContains: userId)
      .snapshots(includeMetadataChanges: true);
}

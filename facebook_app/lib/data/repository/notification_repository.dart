import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';

abstract class NotificationRepository {
  Future<void> updateNotificationPost(
      NotificationPost notification, Post post, String idUserFirst, String idUserSecond);
  Stream<QuerySnapshot> getNotifications(String userId);
}

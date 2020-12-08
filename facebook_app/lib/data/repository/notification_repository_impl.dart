import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/source/remote/fire_base_notification.dart';

import 'notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final FirNotification _firNotification;

  NotificationRepositoryImpl(this._firNotification);

  @override
  Stream<QuerySnapshot> getNotifications(String userId) =>
      _firNotification.getNotifications(userId);

  @override
  Future<void> updateNotificationPost(NotificationPost notification,
          Post post, String idUserFirst, String idUserSecond) =>
      _firNotification.updateNotificationPost(
          notification, post, idUserFirst);
}

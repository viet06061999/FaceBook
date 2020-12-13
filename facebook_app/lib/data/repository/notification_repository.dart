import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';

abstract class NotificationRepository {
  Stream<QuerySnapshot> getNotifications(String userId);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/base_type/friend_status.dart';
import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';

abstract class NotificationPost extends NotificationApp {
  Post post = Post.origin();

  String getContent({String userId});

  NotificationPost(
      String id,
      this.post,
      UserEntity userFirst,
      String updateTime,
      NotificationType type,
      double others,
      List<String> receivers)
      : super(id, userFirst, updateTime, type, others, receivers);

  @override
  NotificationPost.fromJson(Map map, UserEntity userFirst, Post post,
      {UserEntity userSecond})
      : super.fromJson(map, userFirst) {
    this.post = post;
  }

  Map toMap(DocumentReference userFirst,
          {DocumentReference post}) =>
      new Map<String, dynamic>.from({
        "first_user": userFirst,
        "type": this.type.index,
        "update_time": this.updateTime,
        "others": this.others,
        "receivers": this.receivers,
        "post": post
      });
}

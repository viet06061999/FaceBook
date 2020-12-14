import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/user.dart';

class NotificationRequestFriend extends NotificationApp {
  NotificationRequestFriend(String id, UserEntity userFirst, String updateTime,
      double others, List<String> receivers)
      : super(id, userFirst, updateTime, NotificationType.requestFriend, others,
            receivers);

  @override
  String getContent({String userId}) => "đã gửi cho bạn một lời mời kết bạn";
}

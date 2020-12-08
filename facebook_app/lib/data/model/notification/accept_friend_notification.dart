import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/user.dart';

class NotificationAcceptFriend extends Notification {
  NotificationAcceptFriend(UserEntity userFirst, String updateTime,
      double others, List<String> receivers)
      : super(userFirst, updateTime, NotificationType.acceptFriend, others,
            receivers);

  @override
  String getContent({String userId}) => "đã gửi cho bạn một lời mời kết bạn";


}

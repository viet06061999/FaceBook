import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/user.dart';

class NotificationAcceptFriend extends NotificationApp {
  NotificationAcceptFriend(String id, UserEntity userFirst, String updateTime,
      double others, List<String> receivers)
      : super(id, userFirst, updateTime, NotificationType.acceptFriend, others,
            receivers);

  @override
  String getContent({String userId}) => "đã chấp nhận lời mời kết bạn của bạn";
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/user.dart';

abstract class Notification {
  UserEntity userFirst = UserEntity.origin();
  String updateTime = "";
  NotificationType type = NotificationType.requestFriend;
  List<String> receivers = [];
  double others = 0;

  Notification.origin();

  Notification(
      this.userFirst, this.updateTime, this.type, this.others, this.receivers);

  String getContent({String userId});

  Notification.fromJson(
    Map map,
    UserEntity userFirst,
  ) {
    this.userFirst = userFirst;
    this.type = NotificationType.values[int.parse(map['type'].toString())];
    this.updateTime = map['update_time'];
    this.others = map['others'];
    this.receivers =
        (map['receivers'] as List).map((e) => e.toString()).toList();
  }

  Map toMap(DocumentReference userFirst) => new Map<String, dynamic>.from({
        "first_user": userFirst,
        "type": this.type.index,
        "update_time": this.updateTime,
        "others": this.others,
        "receivers": this.receivers,
      });
}

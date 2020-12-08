import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/notification/accept_friend_notification.dart';
import 'package:facebook_app/data/model/notification/request_friend_notification.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/source/remote/fire_base_friend.dart';
import 'package:facebook_app/data/source/remote/fire_base_notification.dart';

import 'friend_repository.dart';

class FriendRepositoryImpl extends FriendRepository {
  final FirFriend _firFriend;
  final FirNotification _firNotification;

  FriendRepositoryImpl(this._firFriend, this._firNotification);

  @override
  acceptRequest(Friend friend, Function onError) {
    _firFriend.acceptRequest(friend, onError);
    var notification = NotificationAcceptFriend(
        friend.userSecond, DateTime.now().toString(), 0, [friend.userFirst.id]);
    _firNotification.createNotificationFriend(
        notification, friend.userSecond.id);
  }

  @override
  createRequestFriend(
      UserEntity userFirst, String idUserSecond, Function onError) {
    _firFriend.createRequestFriend(userFirst.id, idUserSecond, onError);
    var notification = NotificationAcceptFriend(
        userFirst, DateTime.now().toString(), 0, [idUserSecond]);
    _firNotification.createNotificationFriend(notification, userFirst.id);
  }

  @override
  Stream<QuerySnapshot> getFriends(String id) {
    return _firFriend.getFriends(id);
  }

  @override
  Stream<QuerySnapshot> getRequestFriends(String id) {
    return _firFriend.getRequestFriends(id);
  }

  @override
  Stream<QuerySnapshot> getRequestedFriends(String id) {
    return _firFriend.getRequestedFriends(id);
  }
}

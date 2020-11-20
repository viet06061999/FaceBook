import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/source/remote/fire_base_friend.dart';

import 'friend_repository.dart';

class FriendRepositoryImpl extends FriendRepository {
  FirFriend _firFriend;

  FriendRepositoryImpl(this._firFriend);

  @override
  acceptRequest(Friend friend, Function onError) {
    _firFriend.acceptRequest(friend, onError);
  }

  @override
  createRequestFriend(
      String idUserFirst, String idUserSecond, Function onError) {
    _firFriend.createRequestFriend(idUserFirst, idUserSecond, onError);
  }

  @override
  Stream<QuerySnapshot> getListFriend(String id) {
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/base_type/friend_status.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/ultils/string_ext.dart';

class FirFriend {
  final FirebaseFirestore _firestore;

  FirFriend(this._firestore);

  createRequestFriend(String idUserFirst, String idUserSecond,
      Function onError) {
    _createRequest(idUserFirst, idUserSecond, FriendStatus.pendingConfirm.index)
        .catchError((error) => onError());
    _createRequest(idUserSecond, idUserFirst, FriendStatus.pending.index)
        .catchError((error) => onError());
  }

  acceptRequest(Friend friend, Function onError) {
    _acceptRequest(friend.userFirst.id, friend.userSecond.id)
        .catchError((error) => onError());
    _acceptRequest(friend.userSecond.id, friend.userFirst.id)
        .catchError((error) => onError());
  }

  Stream<QuerySnapshot> getFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.accepted.index)
        .snapshots(includeMetadataChanges: true);
  }

  //loi moi ket ban
  Stream<QuerySnapshot> getRequestFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.pending.index)
        .snapshots(includeMetadataChanges: true);
  }

// danh sach da gui loi moi ket ban
  Stream<QuerySnapshot> getRequestedFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.pendingConfirm.index)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> _createRequest(String idUserFirst, String idUserSecond,
      int status) {
    return _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .set({
      'first_user': _firestore.doc('users/' + idUserFirst),
      'second_user': _firestore.doc('users/' + idUserSecond),
      'created': DateTime.now().toString(),
      'modified': DateTime.now().toString(),
      'status': status
    });
  }

  Future<void> _acceptRequest(String idUserFirst, String idUserSecond) {
    return _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .update({
      'modified': DateTime.now().toString(),
      'status': FriendStatus.accepted.index
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/conservation.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook_app/ultils/string_ext.dart';

class FirChat {
  final FirebaseFirestore _firestore;

  FirChat(this._firestore);

  Future<void> sendMessage(Message message, String userIdFrom,
      String userIdTo) async {
    var document =
    _firestore.collection('chats').doc(userIdFrom.encryptDecrypt(userIdTo));
    var usersRef = await document.get();
    Future<void> future = null;

    if (usersRef.exists) {
      future = document.update({
        'messages': FieldValue.arrayUnion([
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ])
      }).then((value) {
        _updateCurrentMessage(message, userIdFrom, userIdTo);
      });
    } else {
      future = document.set({
        'messages': [
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ]
      }).then((value) {
        _updateCurrentMessage(message, userIdFrom, userIdTo);
      });
    }
    return future;
  }

  Future<void> _updateCurrentMessage(Message message, String userIdFrom,
      String userIdTo) async {
    var from = _firestore.doc('users/' + userIdFrom);
    var to = _firestore.doc('users/' + userIdTo);
    var document = _firestore.collection('conservations').doc(
        userIdFrom.encryptDecrypt(userIdTo));
    var usersRef =
    await document.get();
    Future<void> future = null;
    if (usersRef.exists) {
      print('exits');
      future = document
          .update({
        'current_message': message.toMap(from, to)});
    } else {
      print('non exists');
      future = document
          .set({
        'id': userIdFrom.encryptDecrypt(userIdTo),
        'two_id': [userIdFrom, userIdTo],
        'current_message': message.toMap(from, to)});
    }
    return future;
  }

  Stream<QuerySnapshot> getConservations(String userId) =>
      _firestore
          .collection('conservations')
          .where('two_id', arrayContains: userId)
          .snapshots(includeMetadataChanges: true);

  Stream<DocumentSnapshot> getChat(String conservationId) =>
      _firestore
          .collection('chats')
          .doc(conservationId)
          .snapshots(includeMetadataChanges: true);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/conservation.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

class FirChat {
  final FirebaseFirestore _firestore;

  FirChat(this._firestore);

  Future<void> sendMessage(
      Message message, String userIdFrom, String userIdTo) async {
    var usersRef = await _firestore.collection('chats').doc(message.id).get();
    Future<void> future = null;
    if (usersRef.exists) {
      future = _firestore.collection("chats").doc(message.id).update({
        'messages': FieldValue.arrayUnion([
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ])
      }).then((value) {
        _updateCurrentMessage(message, _firestore.doc('users/' + userIdFrom),
            _firestore.doc('users/' + userIdTo));
      });
    } else {
      future = _firestore.collection("chats").doc(message.id).set({
        'id': message.id,
        'messages': [
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ]
      }).then((value) {
        _updateCurrentMessage(message, _firestore.doc('users/' + userIdFrom),
            _firestore.doc('users/' + userIdTo));
      });
    }
    return future;
  }

  Future<void> _updateCurrentMessage(
      Message message, DocumentReference from, DocumentReference to) async {
    var usersRef =
        await _firestore.collection('conservations').doc(message.id).get();
    Future<void> future = null;
    if (usersRef.exists) {
      print('exits');
      future = _firestore
          .collection("conservations")
          .doc(message.id)
          .update({'current_message': message.toMap(from, to)});
    } else {
      print('non exists');
      future = future = _firestore
          .collection("conservations")
          .doc(message.id)
          .set({'current_message': message.toMap(from, to)});
    }

    return future;
  }

  Stream<QuerySnapshot> getConservations() => _firestore
      .collection('conservation')
      .snapshots(includeMetadataChanges: true);

  Stream<DocumentSnapshot> getChat(String conservationId) => _firestore
      .collection('chats')
      .doc(conservationId)
      .snapshots(includeMetadataChanges: true);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String userIdFrom, String userIdTo);

  Stream<QuerySnapshot> getConservations();

  Stream<DocumentSnapshot> getChat(String conservationId);
}

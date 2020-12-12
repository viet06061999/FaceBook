import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/source/remote/fire_base_chat.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirChat _firChat;

  ChatRepositoryImpl(this._firChat);

  @override
  Stream<DocumentSnapshot> getChat(String conservationId) =>
   _firChat.getChat(conservationId);


  @override
  Stream<QuerySnapshot> getConservations(String userId) => _firChat.getConservations(userId);

  @override
  Future<void> sendMessage(Message message, String userIdFrom, String userIdTo) {
     _firChat.sendMessage(message, userIdFrom, userIdTo);
  }
}

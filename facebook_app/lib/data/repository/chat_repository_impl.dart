import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/source/local/user_local_data.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/data/source/remote/fire_base_chat.dart';
import 'package:facebook_app/helper/connect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook_app/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/data/source/remote/fire_base_user_storage.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirChat _firChat;

  ChatRepositoryImpl(this._firChat);

  @override
  Stream<DocumentSnapshot> getChat(String conservationId) =>
   _firChat.getChat(conservationId);


  @override
  Stream<QuerySnapshot> getConservations() => _firChat.getConservations();

  @override
  Future<void> sendMessage(Message message, String userIdFrom, String userIdTo) {
     _firChat.sendMessage(message, userIdFrom, userIdTo);
  }
}

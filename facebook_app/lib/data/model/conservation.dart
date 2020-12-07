import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/model/user.dart';

class Conservation {
  String id;
  UserEntity firstUser = UserEntity.origin();
  UserEntity secondUser = UserEntity.origin();
  Message currentMessage = Message.origin();
  bool isFirstSend = false;

  Conservation.origin();

  Conservation(
      {this.id,
      this.firstUser,
      this.secondUser,
      this.currentMessage,
      this.isFirstSend});

  Conservation.fromMap(Map map, UserEntity first, UserEntity second) {
    this.id = map['conservation_id'];
    this.currentMessage = Message.fromMap(map, getUserSend(), getUserReceive());
    this.firstUser = first;
    this.secondUser = second;
    this.isFirstSend = map['is_first_send'];
  }

  Map toMap(DocumentReference first, DocumentReference second) =>
      new Map<String, dynamic>.from({
        "conservation_id": this.id,
        "is_first_send": this.isFirstSend,
        "first_user": first,
        "second_user": second,
        "current_message": currentMessage.toMap(
          FirebaseFirestore.instance.collection("users").doc(getUserSend().id),
          FirebaseFirestore.instance
              .collection("users")
              .doc(getUserReceive().id),
        )
      });

  UserEntity getUserSend() {
    if (isFirstSend) return firstUser;
    return secondUser;
  }

  UserEntity getUserReceive() {
    if (isFirstSend) return secondUser;
    return firstUser;
  }

  static List<Conservation> fromListMap(
      List<Map> maps, UserEntity fist, UserEntity second) {
    List<Conservation> conservations = [];
    maps.forEach((element) {
      conservations.add(Conservation.fromMap(element, fist, second));
    });
    return conservations;
  }
}

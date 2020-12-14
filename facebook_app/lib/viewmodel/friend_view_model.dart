import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/data/repository/friend_repository.dart';
import 'package:facebook_app/data/repository/notification_repository.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';

class FriendProvide extends HomeProvide {
  //Danh sách lời mời kết bạn chờ xác nhận (firstUser là người gửi lời mời kết bạn)
  List<Friend> _friendWaitConfirm = [];

  List<Friend> get friendWaitConfirm => _friendWaitConfirm;

  //Danh sách lời mời kết bạn đã gửi (firstUser là người gửi lời mời kết bạn)
  List<Friend> _friendRequest = [];

  List<Friend> get friendRequest => _friendRequest;

  FriendProvide(PostRepository repository, PhotoRepository photoRepository,
      UserRepository userRepository, FriendRepository friendRepository, NotificationRepository notificationRepository)
      : super(repository, photoRepository, userRepository, friendRepository, notificationRepository);

  //lời mời kết bạn đã gửi
  getFriendsRequest(UserEntity entity) =>
      friendRepository.getRequestedFriends(entity.id).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
          element.doc.data()['second_user'];
          await documentReference.get().then((value) {
            UserEntity second = UserEntity.fromJson(value.data());
            Friend friend = Friend.fromJson(element.doc.data(), entity, second);
            if (element.type == DocumentChangeType.added) {
              _friendRequest.insert(0, friend);
            } else if (element.type == DocumentChangeType.modified) {
              int position = -1;
              position = _friendRequest.indexWhere(
                      (element) => (element.userSecond == friend.userSecond));

              if (position != -1)
                _friendRequest[position] = friend;
              else
                _friendRequest.insert(0, friend);
            } else if (element.type == DocumentChangeType.removed) {
              _friendRequest.removeWhere(
                      (element) => element.userSecond == friend.userSecond);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});


  //lời mời kết bạn đã nhận
  getFriendsWaitConfirm(UserEntity entity) =>
      friendRepository.getRequestedFriends(entity.id).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
          element.doc.data()['first_user'];
          await documentReference.get().then((value) {
            UserEntity firstUser = UserEntity.fromJson(value.data());
            Friend friend = Friend.fromJson(element.doc.data(), firstUser, entity);
            if (element.type == DocumentChangeType.added) {
              _friendWaitConfirm.insert(0, friend);
            } else if (element.type == DocumentChangeType.modified) {
              int position = -1;
              position = _friendWaitConfirm.indexWhere(
                      (element) => (element.userSecond == friend.userSecond));

              if (position != -1)
                _friendWaitConfirm[position] = friend;
              else
                _friendWaitConfirm.insert(0, friend);
            } else if (element.type == DocumentChangeType.removed) {
              _friendWaitConfirm.removeWhere(
                      (element) => element.userSecond == friend.userSecond);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});
}

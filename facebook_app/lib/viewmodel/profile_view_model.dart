import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/data/repository/friend_repository.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileProvide extends HomeProvide {
  List<Post> _userListPost = [];

  List<Post> get userListPost => _userListPost;

  List<String> _photos = [];

  List<String> get photos => _photos;

  List<Video> _videos = [];

  List<Video> get videos => _videos;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  GlobalKey<NavigatorState> _navigatorKey;

  void init({GlobalKey<NavigatorState> navigatorKey}) {
    _navigatorKey = navigatorKey;
  }

  ProfileProvide(PostRepository repository, PhotoRepository photoRepository,
      UserRepository userRepository, FriendRepository friendRepository)
      : super(repository, photoRepository, userRepository, friendRepository) {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
      getUserListPost(userEntity.id);
      getUserPhotos(userEntity.id);
      getUserVideos(userEntity.id);
    });
  }

  getUserListPost(String userId) =>
      repository.getUserListPost(userId).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference = element.doc.data()['owner'];
          documentReference.get().then((value) {
            UserEntity userPost = UserEntity.fromJson(value.data());
            Post postRoot = Post.fromMap(element.doc.data(), userPost);
            postRoot.isLiked = checkLiked(postRoot.likes);
            if (element.type == DocumentChangeType.added) {
              _userListPost.insert(0, postRoot);
            } else if (element.type == DocumentChangeType.modified) {
              Post post = postRoot;
              int position = -1;
              position = _userListPost.indexWhere(
                (element) =>
                    (element.postId == post.postId) || element.postId == '-1',
              );
              if (position != -1)
                _userListPost[position] = post;
              else
                _userListPost.insert(0, post);
            } else if (element.type == DocumentChangeType.removed) {
              Post post = postRoot;
              _userListPost
                  .removeWhere((element) => element.postId == post.postId);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  updateAvatar(String pathAvatar) {
    userRepository.updateAvatar(pathAvatar, userEntity, () {});
    notifyListeners();
  }

  updateCover(String pathCoverImage) {
    userRepository.updateCoverImage(pathCoverImage, userEntity, () {});
    notifyListeners();
  }

  updateUser(UserEntity userEntity) {
    userRepository.updateUser(userEntity).listen((event) {}, onError: (error) {
      print(error);
    }).onDone(() {});
  }

  updateDescriptionUser(UserEntity userEntity, String description) {
    userRepository.updateDescriptionUser(userEntity, description).listen(
        (event) {
      print("loading");
    }, onError: (error) {
      print(error);
    }).onDone(() {
      print("done");
    });
  }

  getUserPhotos(String userId) =>
      photoRepository.getImagesByUser(userId).listen((event) {
        _photos.addAll(event);
        notifyListeners();
      });

  getUserVideos(String userId) =>
      photoRepository.getVideosByUser(userId).listen((event) {
        _videos.addAll(event);
        notifyListeners();
      });
}

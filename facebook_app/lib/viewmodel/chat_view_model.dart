import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/data/repository/friend_repository.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';

class ChatProvide extends BaseProvide {
  final UserRepository userRepository;
  UserEntity _userEntity = UserEntity.origin();

  ChatProvide(this.userRepository) {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
    });
  }

  UserEntity get userEntity => _userEntity;

  set userEntity(UserEntity userEntity) {
    _userEntity = userEntity;
    notifyListeners();
  }
}

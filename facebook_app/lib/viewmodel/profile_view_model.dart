import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';

class ProfileProvide extends HomeProvide {
  List<Post> _userListPost = [];

  List<Post> get userListPost => _userListPost;

  bool _isTop = true;

  bool get isTop => _isTop;

  set isTop(bool isTop) {
    _isTop = isTop;
    if (_isTop) {
      userListPost.insertAll(0, tmpPosts);
    }
    notifyListeners();
  }

  ProfileProvide(PostRepository repository, PhotoRepository photoRepository,
      UserRepository userRepository)
      : super(repository, photoRepository, userRepository) {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
      getUserListPost(userEntity.id);
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
}

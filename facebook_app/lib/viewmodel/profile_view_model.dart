import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileProvide extends BaseProvide {
  final PostRepository _repository;
  final PhotoRepository _photoRepository;
  final UserRepository _userRepository;
  UserEntity _userEntity = UserEntity.origin();

  //lay % tien trinh upload anh
  List<double> _progressPhoto;

  List<double> get progressPhoto => _progressPhoto;

  set progressPhoto(List list) {
    _progressPhoto = list;
    notifyListeners();
  }

//lay % tien trinh upload video
  double _progressVideo = 0;

  double get progressVideo => _progressVideo;

  set progressVideo(double progress) {
    _progressVideo = progress;
    notifyListeners();
  }

  List<Post> _userListPost = [];

  List<Post> get userListPost => _userListPost;

  List<Post> _tmpPosts = [];

  bool _isTop = true;

  bool get isTop => _isTop;

  set isTop(bool isTop) {
    _isTop = isTop;
    if (_isTop) {
      _userListPost.insertAll(0, _tmpPosts);
      _tmpPosts.clear();
    }
    notifyListeners();
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool _loadingImage = false;

  bool get loadingImage => _loadingImage;

  set loadingImage(bool loading) {
    _loadingImage = loading;
    notifyListeners();
  }

  bool _loadingVideo = false;

  bool get loadingVideo => _loadingVideo;

  set loadingVideo(bool loading) {
    _loadingVideo = loading;
    notifyListeners();
  }

  UserEntity get userEntity => _userEntity;

  set userEntity(UserEntity userEntity) {
    _userEntity = userEntity;
    notifyListeners();
  }

  ProfileProvide(this._repository, this._photoRepository, this._userRepository) {
    _getUserListPost(userEntity.id);
  }

  Observable<void> _createPost(Post post) => _repository
      .createPost(post, userEntity.id)
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  Future<void> uploadPost(String content,
      {List<String> pathImages, String pathVideos}) async {
    Post post = Post("-1", content, DateTime.now().toString(),
        DateTime.now().toString(), [], [], [], Video.origin(), userEntity);
    if (pathImages != null && pathImages.isNotEmpty) {
      loadingImage = true;
      _progressPhoto = new List(pathImages.length);
      pathImages.asMap().forEach((index, element) {
        _photoRepository.uploadPhoto(userEntity.id, element, (urlPath) {
          loadingImage = false;
          post.images.add(urlPath);
          if (index == 0) {
            _createPost(post).listen((event) {
              print("xu ly upload post success o day");
            }, onError: (e) => {print("xu ly upload post fail o day")});
          }
        }, () {
          loadingImage = false;
          print('loi roi xu ly loi upload photo fail ơ đây nhá');
        }, (progress) {
          _progressPhoto[index] = progress;
          print(progress);
          progressPhoto = _progressPhoto;
        });
      });
    } else if (pathVideos != null && pathVideos.isNotEmpty) {
      loadingVideo = true;
      _photoRepository.uploadVideo(userEntity.id, pathVideos, (urlPath) {
        loadingVideo = false;
        post.video.url = urlPath;
        _createPost(post).listen((event) {
          print("xu ly upload post success o day");
        }, onError: (e) => {print("xu ly upload video fail o day")});
      }, () {
        loadingVideo = false;
        print('loi roi xu ly loi upload video fail ơ đây nhá');
      }, (progress) {});
    } else {
      _createPost(post).listen((event) {
        print("xu ly upload post success o day");
      }, onError: (e) => {print("xu ly upload post fail o day")});
    }
  }

  _getUserListPost(String userId) => _repository.getUserListPost(userId).listen((event) async {
    userEntity = await _userRepository.getCurrentUser();
    event.docChanges.forEach((element) async {
      DocumentReference documentReference = element.doc.data()['owner'];
      documentReference.get().then((value) {
        UserEntity userPost = UserEntity.fromJson(value.data());
        Post postRoot = Post.fromMap(element.doc.data(), userPost);
        postRoot.isLiked = _checkLiked(postRoot.likes);
        if (element.type == DocumentChangeType.added) {
          _insertPost(postRoot);
        } else if (element.type == DocumentChangeType.modified) {
          Post post = postRoot;
          int position = -1;
          position = _userListPost.indexWhere(
                (element) =>
            (element.postId == post.postId) || element.postId == '-1',
          );
          int positionTmp = -1;
          positionTmp = _tmpPosts.indexWhere(
                (element) =>
            (element.postId == post.postId) || element.postId == '-1',
          );

          if (position != -1)
            _userListPost[position] = post;
          else if (positionTmp != -1)
            _tmpPosts[positionTmp] = post;
          else
            _insertPost(postRoot);
        } else if (element.type == DocumentChangeType.removed) {
          Post post = postRoot;
          _userListPost.removeWhere((element) => element.postId == post.postId);
        }
      });
      if (event.docChanges.length != 0) {
        notifyListeners();
      }
    });
  }, onError: (e) => {print("xu ly fail o day")});

  void updateLike(Post post) {
    print(post);
    print(post.likes);
    if (post.isLiked) {
      post.likes.removeWhere((element) => element.id == userEntity.id);
    } else {
      post.likes.add(userEntity);
    }
    post.isLiked = !post.isLiked;
    _updatePost(post);
  }

  void addComment(Post post, String content) {
    Comment comment = Comment(userEntity, content);
    post.comments.add(comment);
    _updatePost(post);
  }

  void _updatePost(Post post) {
    _repository.updatePost(post, userEntity.id);
  }

  _insertPost(Post post) {
    print(post);
    if (isTop) {
      _userListPost.insert(0, post);
    } else {
      _tmpPosts.add(post);
    }
    notifyListeners();
  }

  bool _checkLiked(List<UserEntity> users) {
    if (users.length == 0) return false;
    return users.firstWhere((element) => element.id == userEntity.id,
        orElse: () => null) !=
        null;
  }
}

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

class HomeProvide extends BaseProvide {
  final PostRepository _repository;
  final PhotoRepository _photoRepository;
  final UserRepository _userRepository;
  UserEntity _userEntity;

  List<Post> _listPost = [];

  List<Post> get listPost => _listPost;

  List<Post> _tmpPosts = [];

  bool _isTop = true;

  bool get isTop => _isTop;

  set isTop(bool isTop) {
    _isTop = isTop;
    print(_tmpPosts.length);
    if (_isTop) {
      _listPost.insertAll(0, _tmpPosts);
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

  HomeProvide(this._repository, this._photoRepository, this._userRepository) {
    _getListPost();
    _userRepository.getCurrentUser().then((value) {
      userEntity = value;
    });
  }

  Observable<void> _createPost(Post post) => _repository
      .createPost(post)
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  void uploadPost(String content,
      {List<String> pathImages, String pathVideos}) {
    Post post = Post("-1", content, DateTime.now().toString(),
        DateTime.now().toString(), [], [], [], Video.origin(), userEntity);
    if (pathImages != null && pathImages.isNotEmpty) {
      loadingImage = true;
      pathImages.forEach((element) {
        _photoRepository.uploadPhoto(element, (urlPath) {
          loadingImage = false;
          post.images.add(urlPath);
          _createPost(post).listen((event) {
            print("xu ly upload post success o day");
          }, onError: (e) => {print("xu ly upload post fail o day")});
        }, () {
          loadingImage = false;
          print('loi roi xu ly loi upload photo fail ơ đây nhá');
        });
      });
    } else if (pathVideos != null && pathVideos.isNotEmpty) {
      loadingVideo = true;
      _photoRepository.uploadVideo(pathVideos, (urlPath) {
        loadingVideo = false;
        post.video.url = urlPath;
        _createPost(post).listen((event) {
          print("xu ly upload post success o day");
        }, onError: (e) => {print("xu ly upload video fail o day")});
      }, () {
        loadingVideo = false;
        print('loi roi xu ly loi upload video fail ơ đây nhá');
      });
    } else {
      _createPost(post).listen((event) {
        print("xu ly upload post success o day");
      }, onError: (e) => {print("xu ly upload post fail o day")});
    }
  }

  void _getListPost() => _repository.getListPost().listen((event) {
        event.docChanges.forEach((element) {
          Post postRoot = Post.fromMap(element.doc.data());
          postRoot.isLiked = postRoot.likes.contains(userEntity);
          if (element.type == DocumentChangeType.added) {
            _insertPost(postRoot);
          } else if (element.type == DocumentChangeType.modified) {
            Post post = postRoot;
            int position = -1;
            position = _listPost.indexWhere(
              (element) =>
                  (element.postId == post.postId) || element.postId == '-1',
            );
            int positionTmp = -1;
            positionTmp = _tmpPosts.indexWhere(
              (element) =>
                  (element.postId == post.postId) || element.postId == '-1',
            );

            if (position != -1)
              _listPost[position] = post;
            else if (positionTmp != -1)
              _tmpPosts[positionTmp] = post;
            else
              _insertPost(postRoot);
          } else if (element.type == DocumentChangeType.removed) {
            Post post = postRoot;
            _listPost.removeWhere((element) => element.postId == post.postId);
          }
        });
        if (event.docChanges.length != 0) {
          notifyListeners();
        }
      }, onError: (e) => {print("xu ly fail o day")});

  void updateLike(Post post){
    if(post.likes.contains(userEntity)){
      post.likes.removeWhere((element) => element.id == userEntity.id);
    }else{
      post.likes.add(userEntity);
    }
    _updatePost(post);
  }

  void addComment(Post post, String content){
    Comment comment = Comment(userEntity, content);
    post.comments.add(comment);
    _updatePost(post);
  }

  void _updatePost(Post post){
    _repository.updatePost(post);
  }

  _insertPost(Post post) {
    if (isTop) {
      _listPost.insert(0, post);
    } else {
      _tmpPosts.add(post);
    }
  }
}

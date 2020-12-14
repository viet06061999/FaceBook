import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/base_type/friend_status.dart';
import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/notification/accept_friend_notification.dart';
import 'package:facebook_app/data/model/notification/comment_post_notification.dart';
import 'package:facebook_app/data/model/notification/like_post_notification.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';
import 'package:facebook_app/data/model/notification/request_friend_notification.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/data/repository/friend_repository.dart';
import 'package:facebook_app/data/repository/notification_repository.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvide extends BaseProvide {
  final PostRepository repository;
  final PhotoRepository photoRepository;
  final UserRepository userRepository;
  final FriendRepository friendRepository;
  final NotificationRepository notificationRepository;
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

  List<Post> _listPost = [];

  List<Post> get listPost => _listPost;

  List<Post> tmpPosts = [];

  List<NotificationApp> _notifications = [];

  List<NotificationApp> get notifications => _notifications;

  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  List<Friend> _friendsPending = [];

  List<Friend> get friendsPending => _friendsPending;

  bool _isTop = true;

  bool get isTop => _isTop;

  set isTop(bool isTop) {
    _isTop = isTop;
    if (_isTop) {
      listPost.insertAll(0, tmpPosts);
      tmpPosts.clear();
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

  HomeProvide(this.repository, this.photoRepository, this.userRepository,
      this.friendRepository, this.notificationRepository);

  init() {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
      _getListPost();
      getFriends(userEntity);
      getPendings(userEntity);
      getNotifications();
    });
  }

  Observable<void> _createPost(Post post) => repository
      .createPost(post, userEntity.id)
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  Future<void> uploadPost(String content,
      {List<String> pathImages, String pathVideos}) async {
    print(pathImages);
    Post post = Post("-1", content, DateTime.now().toString(),
        DateTime.now().toString(), [], [], [], Video.origin(), userEntity);
    if (pathImages != null && pathImages.isNotEmpty) {
      loadingImage = true;
      _progressPhoto = new List(pathImages.length);
      pathImages.asMap().forEach((index, element) async {
        await photoRepository.uploadPhoto(userEntity.id, element, (urlPath) {
          loadingImage = false;
          print(urlPath);
          post.images.add(urlPath);
          if (index == pathImages.length - 1) {
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
      photoRepository.uploadVideo(userEntity.id, pathVideos, (urlPath) {
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

  _getListPost() => repository.getListPost().listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference = element.doc.data()['owner'];
          documentReference.get().then((value) {
            UserEntity userPost = UserEntity.fromJson(value.data());
            Post postRoot = Post.fromMap(element.doc.data(), userPost);
            postRoot.isLiked = checkLiked(postRoot.likes);
            if (element.type == DocumentChangeType.added) {
              _insertPost(postRoot);
            } else if (element.type == DocumentChangeType.modified) {
              print('thay doi');
              Post post = postRoot;
              int position = -1;
              position = _listPost.indexWhere(
                (element) =>
                    (element.postId == post.postId) || element.postId == '-1',
              );
              int positionTmp = -1;
              positionTmp = tmpPosts.indexWhere(
                (element) =>
                    (element.postId == post.postId) || element.postId == '-1',
              );
              print('position $position tmp $positionTmp');
              if (position != -1)
                _listPost[position] = post;
              else if (positionTmp != -1)
                tmpPosts[positionTmp] = post;
              else
                _insertPost(postRoot);
              notifyListeners();
            } else if (element.type == DocumentChangeType.removed) {
              Post post = postRoot;
              _listPost.removeWhere((element) => element.postId == post.postId);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  getFriends(UserEntity entity) {
    _friends.clear();
    friendRepository.getFriends(entity.id).listen((event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReference = element.doc.data()['second_user'];
        await documentReference.get().then((value) {
          UserEntity second = UserEntity.fromJson(value.data());
          Friend friend = Friend.fromJson(element.doc.data(), entity, second);
          if (element.type == DocumentChangeType.added) {
            _friends.insert(0, friend);
          } else if (element.type == DocumentChangeType.modified) {
            int position = -1;
            position = _friends.indexWhere(
                (element) => (element.userSecond == friend.userSecond));
            if (position != -1)
              _friends[position] = friend;
            else
              _friends.insert(0, friend);
          } else if (element.type == DocumentChangeType.removed) {
            _friends.removeWhere(
                (element) => element.userSecond == friend.userSecond);
          }
        });
        if (event.docChanges.length != 0) {
          notifyListeners();
        }
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  getNotifications() {
    print('get thong bao nay');
    notificationRepository.getNotifications(userEntity.id).listen(
        (event) async {
      event.docChanges.forEach((element) async {
        print('vao element');
        DocumentReference documentReference = element.doc.data()['first_user'];
        await documentReference.get().then((value) async {
          UserEntity user = UserEntity.fromJson(value.data());
          print(user.firstName);
          NotificationApp notification;
          var map = element.doc.data();
          NotificationType type =
              NotificationType.values[int.parse(map['type'].toString())];
          switch (type) {
            case NotificationType.acceptFriend:
              {
                notification = NotificationAcceptFriend(
                    map['id'],
                    user,
                    map['update_time'],
                    map['others'],
                    (map['receivers'] as List)
                        .map((e) => e.toString())
                        .toList());
                _insertNotification(element.type, notification);
                notifyListeners();
              }
              break;
            case NotificationType.requestFriend:
              {
                notification = NotificationRequestFriend(
                    map['id'],
                    user,
                    map['update_time'],
                    map['others'],
                    (map['receivers'] as List)
                        .map((e) => e.toString())
                        .toList());
                _insertNotification(element.type, notification);
                notifyListeners();
              }
              break;
            case NotificationType.likePost:
              {
                DocumentReference documentReference =
                    element.doc.data()['owner'];
                documentReference.get().then((value) {
                  UserEntity userPost = UserEntity.fromJson(value.data());
                  Post post = Post.fromMap(element.doc.data(), userPost);
                  notification = NotificationLikePost(
                      map['id'],
                      post,
                      user,
                      map['update_time'],
                      map['others'],
                      (map['receivers'] as List)
                          .map((e) => e.toString())
                          .toList());
                  _insertNotification(element.type, notification);
                  notifyListeners();
                });
              }
              break;
            case NotificationType.commentPost:
              {
                DocumentReference documentReference =
                    element.doc.data()['owner'];
                documentReference.get().then((value) {
                  UserEntity userPost = UserEntity.fromJson(value.data());
                  Post post = Post.fromMap(element.doc.data(), userPost);
                  notification = NotificationCommentPost(
                      map['id'],
                      post,
                      user,
                      map['update_time'],
                      map['others'],
                      (map['receivers'] as List)
                          .map((e) => e.toString())
                          .toList());
                  _insertNotification(element.type, notification);
                  notifyListeners();
                });
              }
              break;
          }
        });
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  getPendings(UserEntity entity) {
    _friendsPending.clear();
    friendRepository.getRequestFriends(entity.id).listen((event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReference = element.doc.data()['second_user'];
        await documentReference.get().then((value) {
          UserEntity second = UserEntity.fromJson(value.data());
          Friend friend = Friend.fromJson(element.doc.data(), entity, second);
          if (element.type == DocumentChangeType.added) {
            _friendsPending.insert(0, friend);
          } else if (element.type == DocumentChangeType.modified) {
            int position = -1;
            position = _friendsPending.indexWhere(
                (element) => (element.userSecond == friend.userSecond));
            if (position != -1)
              _friendsPending[position] = friend;
            else
              _friendsPending.insert(0, friend);
          } else if (element.type == DocumentChangeType.removed) {
            _friendsPending.removeWhere(
                (element) => element.userSecond == friend.userSecond);
          }
        });
        if (event.docChanges.length != 0) {
          notifyListeners();
        }
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  bool checkFriend(String idThey) {
    return _friends.firstWhere((element) {
              return (element.userFirst.id == idThey ||
                  element.userSecond.id == idThey) && element.status == FriendStatus.accepted;
            }, orElse: null) == null ? false : true;
  }

  void updateLike(Post post) {
    print(post.isLiked);
    if (post.isLiked) {
      post.likes.removeWhere((element) => element.id == userEntity.id);
      repository.updateDisLikePost(post, userEntity);
    } else {
      post.likes.add(userEntity);
      repository.updateLikePost(post, userEntity);
    }
    post.isLiked = !post.isLiked;
  }

  void addComment(Post post, String content) {
    Comment comment = Comment(userEntity, content);
    post.comments.add(comment);
    repository.updateComment(post, comment);
  }

  _insertPost(Post post) {
    if (isTop) {
      _listPost.insert(0, post);
    } else {
      tmpPosts.add(post);
    }
    notifyListeners();
  }

  _insertNotification(DocumentChangeType type, NotificationApp notification) {
    if (type == DocumentChangeType.added) {
      _notifications.insert(0, notification);
    } else if (type == DocumentChangeType.modified) {
      int position = -1;
      position = _notifications
          .indexWhere((element) => (element.id == notification.id));
      if (position != -1)
        _notifications[position] = notification;
      else
        _notifications.insert(0, notification);
    }
  }

  bool checkLiked(List<UserEntity> users) {
    if (users.length == 0) return false;
    return users.firstWhere((element) => element.id == userEntity.id,
            orElse: () => null) !=
        null;
  }
}

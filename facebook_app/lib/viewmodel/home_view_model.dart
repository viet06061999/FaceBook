import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvide extends BaseProvide {
  final PostRepository _repository;
  final PhotoRepository _photoRepository;
  List<Post> _listPost = [];

  bool _loading = false;

  bool get loading => _loading;

  List<Post> get listPost => _listPost;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  HomeProvide(this._repository, this._photoRepository) {
    _getListPost();
  }

  Observable<void> _createPost(Post post) => _repository
      .createPost(post)
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  void uploadPost(Post post, String filePath) {
    _photoRepository.uploadPhoto(filePath, (urlPath) {
      post.images.add(urlPath);
      _createPost(post).listen((event) {
        print("xu ly upload post success o day");
      }, onError: (e) => {print("xu ly upload post fail o day")});
    }, () {
      print('loi roi xu ly loi upload photo fail ơ đây nhá');
    });
  }

  void _getListPost() => _repository.getListPost().listen((event) {
        print('${event.docChanges.length} ${event.docChanges}');
        event.docChanges.forEach((element) {
          print(element.type);
          if (element.type == DocumentChangeType.added) {
            _listPost.insert(0, Post.fromMap(element.doc.data()));
          }
          if (element.type == DocumentChangeType.modified) {
            Post post = Post.fromMap(element.doc.data());
            int position = -1;
            position = _listPost.indexWhere(
              (element) =>
                  (element.postId == post.postId) || element.postId == '-1',
            );
            if (position != -1)
              _listPost[position] = post;
            else
              _listPost.insert(0, post);
          }
          if (element.type == DocumentChangeType.removed) {
            Post post = Post.fromMap(element.doc.data());
            _listPost.removeWhere((element) => element.postId == post.postId);
          }
        });
        if (event.docChanges.length != 0) {
          notifyListeners();
        }
      }, onError: (e) => {print("xu ly fail o day")});
}

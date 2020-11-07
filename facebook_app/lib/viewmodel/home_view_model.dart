import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvide extends BaseProvide {
  final PostRepository _repository;
  final PhotoRepository _photoRepository;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  HomeProvide(this._repository, this._photoRepository);

  Observable<DocumentReference> createPost(Post post) => _repository
      .createPost(post)
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  void uploadPost(Post post, String filePath) {
    _photoRepository.uploadPhoto(filePath, (urlPath) {
      post.images.add(urlPath);
      createPost(post).listen((event) {
        print("xu ly upload post success o day");
      },onError: (e) => {
        print("xu ly upload post fail o day")
      });
    }, () {
      print('loi roi xu ly loi upload photo fail ơ đây nhá');
    });
  }
}

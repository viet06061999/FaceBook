import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/helper/constants.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserRepositoryImpl implements UserRepository {
  final FirAuth _firAuth;
  final SpUtil _spUtil;

  UserRepositoryImpl(this._firAuth, this._spUtil);

  @override
  void signUp(UserEntity user, Function onSuccess, Function(String code) onError) {
    _firAuth.signUp(user.firstName, user.lastName, user.avatar, user.birthday,
        user.email, user.phone, user.password, user.genre, onSuccess, onError);
  }

  @override
  Observable<UserCredential> signIn(String email, String password) {
    return _firAuth.signIn(email, password);
  }

  @override
  Future<User> currentUser() {
    return _firAuth.curentUser();
  }

  @override
  Future<String> getCurrentUserLocal() {
    return _spUtil.getString(KEY_CURRENT_USER);
  }

  @override
  Future<void> setCurrentUser(String email) {
    return _spUtil.putString(KEY_CURRENT_USER, email);
  }
}

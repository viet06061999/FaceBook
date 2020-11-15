import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/source/local/user_local_data.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/helper/connect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserRepositoryImpl implements UserRepository {
  final FirAuth _firAuth;
  final UserLocalDatasource _localDatasource;

  UserRepositoryImpl(this._firAuth, this._localDatasource);

  @override
  void signUp(
      UserEntity user, Function onSuccess, Function(String code) onError) {
    _firAuth.signUp(user.firstName, user.lastName, user.avatar, user.birthday,
        user.email, user.phone, user.password, user.genre, onSuccess, onError);
  }

  @override
  Observable<UserCredential> signIn(String email, String password) {
    return _firAuth.signIn(email, password);
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    bool isNetworkAvailable = await isAvailableInternet();
    if (isNetworkAvailable) {
      UserEntity entity = await _firAuth.curentUser();
      if (entity != null) setCurrentUser(entity);
      return entity;
    }
    return Future.value(_localDatasource.getCurrentUserLocal());
  }

  @override
  Future<void> setCurrentUser(UserEntity userEntity) {
    return _localDatasource.setCurrentUser(userEntity);
  }

  @override
  void logOut() {
    _localDatasource.clearUser();
    _firAuth.signOut(() {});
  }
}

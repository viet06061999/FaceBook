
import 'package:facebook_app/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {
  Observable<UserCredential> signIn(String email, String password);

  void signUp(UserEntity user, Function onSuccess, Function(String code) onError);

  Future<User> currentUser();

  Future<void> setCurrentUser(String email);

  Future<String> getCurrentUserLocal();
}

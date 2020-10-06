import 'package:facebook_app/src/data/model/user.dart';

abstract class UserRepository {
  void signIn(String email, String password, Function onSuccess,
      Function(String) onError);

  void signUp(User user, Function onSuccess, Function(String code) onError);

  Future<String> currentUser();
}

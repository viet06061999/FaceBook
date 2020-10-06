import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/firebase/fire_base_auth.dart';

class UserRepositoryImpl implements UserRepository {
  var firAuth = FirAuth();

  @override
  void signUp(User user, Function onSuccess, Function(String code) onError) {
    firAuth.signUp(user.firstName, user.lastName, user.birthday, user.email,
        user.phone, user.password, onSuccess, onError);
  }

  @override
  void signIn(String email, String password, Function onSuccess,
      Function(String p1) onError) {
    firAuth.signIn(email, password, onSuccess, onError);
  }

  @override
  Future<String> currentUser() {
    return firAuth.curentUser();
  }

}

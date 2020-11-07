import 'dart:async';
import 'package:dartin/dartin.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/repository/user_repository_impl.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/helper/share_prefs.dart';

class RegisterBloc {
  UserRepository _userRepositoryImpl =
      UserRepositoryImpl(inject<FirAuth>(), inject<SpUtil>());

  StreamController _emailController = StreamController.broadcast();

  Stream get emailStream => _emailController.stream;

  void signUp(UserEntity user, Function onSuccess, Function onError) {
    _userRepositoryImpl.signUp(user, onSuccess, (code) {
      _onSignUpErr(code);
      onError();
    });
  }

  void _onSignUpErr(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        _emailController.sink.addError("Email đã tồn tại");
        break;
      default:
    }
  }

  void dispose() {
    _emailController.close();
  }
}

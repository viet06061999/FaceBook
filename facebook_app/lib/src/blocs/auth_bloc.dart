import 'dart:async';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class RegisterBloc {
  UserRepository _userRepositoryImpl = UserRepositoryImpl();

  StreamController _emailController = StreamController.broadcast();
  Stream get emailStream => _emailController.stream;

  void signUp(User user, Function onSuccess, Function onError) {
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

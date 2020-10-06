import 'dart:async';

import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/validators/user_validation.dart';

class LoginBloc {
  StreamController _userController = new StreamController.broadcast();
  StreamController _passController = new StreamController.broadcast();

  Stream get userStream => _userController.stream;

  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String password) {
    bool result = true;
    if (!UserValidation.isValidUser(username)) {
      _userController.sink.addError("Tài khoản không hợp lệ");
      result = result && false;
    } else {
      _userController.sink.add("OK");
      result = result && true;
    }

    if (!UserValidation.isValidPassword(password)) {
      _passController.sink.addError("Mật khẩu phải trên 6 ký tự");
      result = result && false;
    } else {
      _passController.sink.add("OK");
      result = result && true;
    }
    return result && UserRepositoryImpl().isUser(User.origin());
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}

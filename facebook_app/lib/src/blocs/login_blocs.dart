import 'dart:async';

import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';
class LoginBloc {
  UserRepository _userRepository = UserRepositoryImpl();

  StreamController _userController = new StreamController.broadcast();
  StreamController _passController = new StreamController.broadcast();

  Stream get userStream => _userController.stream;

  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String password) {
    bool result = true;
    if (username.isEmpty) {
      _userController.sink.addError("vui lòng nhập email");
      result = result && false;
    } else {
      _userController.sink.add("OK");
      result = result && true;
    }

    if (!password.isValidPassword()) {
      _passController.sink.addError("Mật khẩu phải trên 8 ký tự");
      result = result && false;
    } else {
      _passController.sink.add("OK");
      result = result && true;
    }
    return result;
  }

void signIn(String email, String password,Function onSuccess, Function onError){
    _userRepository.signIn(email, password, onSuccess, (code){
      print(code);
      _onSignInErr(code);
      onError();
    });
}

  void _onSignInErr(String code) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        _userController.sink.addError("Email không hợp lệ");
        break;
      case "ERROR_WEAK_PASSWORD":
        _passController.sink.addError("Mật khẩu quá ngắn");
        break;
      case "ERROR_WRONG_PASSWORD":
       _passController.sink.addError("Mật khẩu không chính xác");
        break;
      case "ERROR_USER_NOT_FOUND":
        _userController.sink.addError("Tài khoản không tồn tại");
        break;
      case "ERROR_USER_DISABLED":
        _userController.sink.addError("Tài khoản đã bị vô hiệu hóa");
        break;
      default:
    }
  }
  void dispose() {
    _userController.close();
    _passController.close();
  }
}

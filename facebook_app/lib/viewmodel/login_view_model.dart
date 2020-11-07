import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook_app/ultils/string_ext.dart';

class LoginProvide extends BaseProvide {
  final UserRepository _repository;
  String email = "";
  String password = "";
  String _errEmail = null;
  String _errPassword = null;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  String get errEmail => _errEmail;

  set errEmail(String err) {
    _errEmail = err;
    notifyListeners();
  }

  String get errPassword => _errPassword;

  set errPassword(String err) {
    _errPassword = err;
    notifyListeners();
  }

  LoginProvide(this._repository);

  Observable<UserCredential> login() => _repository
      .signIn(email, password.toSha256())
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  void dispatchFailure(e) {
    print(e);
    var errE = null;
    var errP = null;
    switch (e) {
      case "ERROR_INVALID_EMAIL":
        errE = "Email không hợp lệ";
        break;
      case "ERROR_WEAK_PASSWORD":
        errP = "Mật khẩu quá ngắn";
        break;
      case "ERROR_WRONG_PASSWORD":
        errP = "Mật khẩu không chính xác";
        break;
      case "ERROR_USER_NOT_FOUND":
        errE = "Tài khoản không tồn tại";
        break;
      case "ERROR_USER_DISABLED":
        errE = "Tài khoản đã bị vô hiệu hóa";
        break;
      default:
    }
    errEmail = errE;
    errPassword = errP;
  }

  bool isValidInfo() {
    bool result = true;
    var errE = null;
    var errP = null;
    if (email.isEmpty) {
      errE = "vui lòng nhập email";
      result = result && false;
    } else if (!email.isValidEmail()) {
      errE = "email không hợp lệ";
      result = result && false;
    } else {
      errE = null;
      result = result && true;
    }

    if (!password.isValidPassword()) {
      errP = "Mật khẩu phải trên 8 ký tự";
      result = result && false;
    } else {
      errP = null;
      result = result && true;
    }
    errEmail = errE;
    errPassword = errP;
    print('$errEmail $errPassword');
    return result;
  }
}

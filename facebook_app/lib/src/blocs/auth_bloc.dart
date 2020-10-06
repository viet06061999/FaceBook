import 'dart:async';

import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/firebase/fire_base_auth.dart';
import 'package:facebook_app/src/validators/user_validation.dart';

class RegisterBloc {
  StreamController _firstNameController = new StreamController.broadcast();
  StreamController _lastNameController = new StreamController.broadcast();
  StreamController _birthdayController = new StreamController.broadcast();
  StreamController _emailController = new StreamController.broadcast();
  StreamController _phoneController = new StreamController.broadcast();
  StreamController _passController = new StreamController.broadcast();

  var firAuth = FirAuth();
  Stream get firstNameStream => _firstNameController.stream;

  Stream get lastNameStream => _lastNameController.stream;

  Stream get birthdayStream => _birthdayController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get passStream => _passController.stream;

  bool isValidInfo(
      String firstName,
      String lastName,
      String birthday,
      String email,
      String phone,
      String password) {
    bool result = true;
    if (!UserValidation.isValidString(firstName)) {
      _firstNameController.sink.addError("Vui lòng nhập Họ");
      result = result && false;
    } else {
      _firstNameController.sink.add("OK");
      result = result && true;
    }
    if (!UserValidation.isValidString(lastName)) {
      _lastNameController.sink.addError("Vui lòng nhập Tên");
      result = result && false;
    } else {
      _lastNameController.sink.add("OK");
      result = result && true;
    }
    if (!UserValidation.isValidString(birthday)) {
      _birthdayController.sink.addError("Vui lòng nhập ngày sinh");
      result = result && false;
    } else {
      _birthdayController.sink.add("OK");
      result = result && true;
    }
    if (!UserValidation.isValidString(email)) {
      _emailController.sink.addError("Vui lòng nhập email");
      result = result && false;
    } else {
      _emailController.sink.add("OK");
      result = result && true;
    }
    if (!UserValidation.isValidString(phone)) {
      _phoneController.sink.addError("Vui lòng nhập số điện thoại");
      result = result && false;
    } else {
      _phoneController.sink.add("OK");
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

  void signUp(String firstName, String lastName, String birthday, String email,
      String phone, String password, Function onSuccess){
      firAuth.signUp(firstName, lastName, birthday, email, phone, password, onSuccess);
  }

  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _phoneController.close();
    _emailController.close();
    _birthdayController.close();
    _passController.close();
  }
}

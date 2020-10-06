import 'dart:core';

class User {
  String id = '-1';
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String birthday = '';
  String password = '';

  User.origin();

  User(this.id, this.firstName, this.lastName, this.birthday, this.email,
      this.phone, this.password);
}

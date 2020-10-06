class UserValidation {
  static bool isValidUser(String username) {
    return username.isNotEmpty;
  }

  static bool isValidPassword(String password) {
    return password.length > 6;
  }

  static bool isValidString(String s){
    return s.length > 0;
  }
}

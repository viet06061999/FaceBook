class UserValidation {
  static bool isValidUser(String username) {
    return username.isNotEmpty;
  }

  static bool isValidPassword(String password) {
    return password.length > 6;
  }
}

import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringX on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isValidPassword() {
    return this.length >= 8;
  }

  String toSha256() {
    return sha256.convert(utf8.encode(this)).toString();
  }

  String xorString(String thatString) {
    String output = this + thatString;
    return output.toSha256();
  }

  String encryptDecrypt(String input) {
    var first = this.substring(0, 6);
    var second = input.substring(0, 6);
    var output = [];
    for(var i = 0; i < 6; i++) {
      var charCode = first.codeUnitAt(i) ^ second.codeUnitAt(i);
      output.add(new String.fromCharCode(charCode));
    }
    return output.join("").toSha256();
  }
}

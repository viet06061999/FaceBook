import 'package:facebook_app/src/blocs/auth_bloc.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegisterPageSave extends StatefulWidget {
  User _user;

  RegisterPageSave(this._user);

  @override
  State<StatefulWidget> createState() => _RegisterPageSave(_user);
}

class _RegisterPageSave extends State<RegisterPageSave> {
  User _user;

  _RegisterPageSave(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextTop(),
              buildTextOfTop(),
              buildButtonContinue(),
              buildText()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtonContinue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onContinueClick,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Xác nhận",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Padding buildTextTop() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: Text(
        "Lưu thông tin đăng nhập của bạn",
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
    );
  }

  Text buildTextOfTop() {
    return Text(
      "Lần tới khi đăng nhập vào điện thoại này bạn chỉ cần nhấn vào ảnh thay vì nhập mật khẩu",
      style: TextStyle(fontSize: 14, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Padding buildText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: new Text(
              "Lúc khác",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: new Text(
              "Ok",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  onContinueClick() {}
}

import 'package:facebook_app/src/blocs/login_blocs.dart';
import 'package:facebook_app/src/resources/progress_dialog.dart';
import 'file:///C:/Users/vietl/Desktop/FaceBook/facebook_app/lib/src/resources/register/register_page_step_one.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;
  bool isTextNull = true;
  LoginBloc bloc = new LoginBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildTopBackground(),
                buildUserInput(),
                buildPasswordInput(),
                buildButtonSignIn(),
                buildForgotPassword(),
                buildDeliver(context),
                buildButtonSignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildButtonSignUp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: SizedBox(
        child: Wrap(
          children:[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context,
                   "/second");
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(8)))),
              color: Colors.green,
              child: Text(
                "Tạo tài khoản facebook mới",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ]
        ),
      ),
    );
  }

  GestureDetector buildForgotPassword() {
    return GestureDetector(
      onTap: () {
      },
      child: new Text("Quên mật khẩu?",style: TextStyle(fontSize: 16, color: Colors.blue),),
    );
  }

  Padding buildDeliver(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Text("HOẶC"),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ]),
              );
  }

  Padding buildButtonSignIn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onSignInClicked,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Đăng nhập",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Padding buildPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: StreamBuilder(
            builder: (context, snapshot) => TextField(
                  controller: _passController,
                  onChanged: (text) {
                    setState(() {
                      isTextNull = text.isEmpty;
                    });
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xff888888)),
                    labelText: "Mật khẩu",
                    errorText: snapshot.hasError ? snapshot.error : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                    suffixIcon: Visibility(
                      visible: !isTextNull,
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        child: new Icon(_showPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
            stream: bloc.passStream));
  }

  Padding buildUserInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        child: StreamBuilder(
          builder: (context, snapshot) => TextField(
            controller: _userController,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
                labelText: "Số điện thoại hoặc email",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.person, color: Color(0xff888888)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15)),
          ),
          stream: bloc.userStream,
        ));
  }

  Container buildTopBackground() {
    return Container(
      child: Image.asset('assets/images/top_background.jpg'),
    );
  }

  void onSignInClicked() {
    ProgressLoading dialog = ProgressLoading();
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      dialog.showLoading(context, "Loading...");
      bloc.signIn(_userController.text, _passController.text, () {
        dialog.hideLoading();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }, () {
        dialog.hideLoading();
      });
    }
  }
}

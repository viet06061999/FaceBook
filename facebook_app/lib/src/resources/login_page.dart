import 'package:facebook_app/src/blocs/login_blocs.dart';
import 'package:facebook_app/src/resources/progress_dialog.dart';
import 'package:facebook_app/src/resources/register_page.dart';
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
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildFavicon(),
                buildTitle(),
                buildUserInput(),
                buildPasswordInput(),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(
                    "Quên mật khẩu?",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
                buildButtonSignIn(),
                buildBottom()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildBottom() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: RichText(
        text: TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            text: "Đăng ký tài khoản facebook mới?",
            style: TextStyle(color: Colors.blue, fontSize: 16)),
      ),
    );
  }

  Padding buildButtonSignIn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: StreamBuilder(
          builder: (context, snapshot) => TextField(
            controller: _userController,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
                labelText: "Email hoặc số điện thoại",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.person, color: Color(0xff888888)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15)),
          ),
          stream: bloc.userStream,
        ));
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
      child: Text(
        "Hello\nWelcome Back",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
    );
  }

  Center buildFavicon() {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Image.asset('assets/images/fb_favicon.png')),
    );
  }

  void onSignInClicked() {
    ProgressLoading dialog = ProgressLoading();
    dialog.showLoading(context, "Loading...");
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      bloc.signIn(_userController.text, _passController.text, (){
        dialog.hideLoading();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }, (){
        dialog.hideLoading();
      });
    }
  }
}

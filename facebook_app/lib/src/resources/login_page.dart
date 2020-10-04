import 'package:facebook_app/src/blocs/login_blocs.dart';
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
          child: ListView(
            children: <Widget>[
              buildFavicon(),
              buildTitle(),
              buildUserInput(),
              buildPasswordInput(),
              buildButtonSignIn(),
              buildBottom()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildBottom() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New user? SIGN UP",
              style: TextStyle(fontSize: 15, color: Color(0xff888888)),
            ),
            Text(
              "Forgot password?",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  Padding buildButtonSignIn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onSignInClicked,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "SIGN iN",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Padding buildPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
                        Icon(Icons.lock_outlined, color: Color(0xff888888)),
                    labelText: "Password",
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
                labelText: "Username",
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
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}

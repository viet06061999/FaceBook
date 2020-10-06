import 'package:facebook_app/src/blocs/auth_bloc.dart';
import 'package:facebook_app/src/resources/home_page.dart';
import 'package:facebook_app/src/resources/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:facebook_app/src/ultils/context_ext.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPass = false;
  bool _isTextNull = true;
  RegisterBloc _registerBloc = RegisterBloc();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildFavicon(),
              buildTextTop(),
              buildTextBottom(),
              buildNameInput(),
              buildTexbirthday(),
              buildTexEmail(),
              buildTexPhone(),
              buildPasswordInput(),
              buildButtonSignUp()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtonSignUp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onSignUpClicked,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Đăng ký",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Padding buildPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: StreamBuilder(
            builder: (context, snapshot) => TextField(
                  onChanged: (text) {
                    setState(() {
                      _isTextNull = text.isEmpty;
                    });
                  },
                  controller: _passController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    errorText: snapshot.hasError ? snapshot.error : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                    suffixIcon: Visibility(
                      visible: !_isTextNull,
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
            stream: _registerBloc.passStream));
  }

  StreamBuilder buildTexPhone() {
    return StreamBuilder(
        builder: (context, snapshot) => TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  errorText: snapshot.hasError ? snapshot.error : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelStyle:
                      TextStyle(color: Color(0xff888888), fontSize: 15)),
            ),
        stream: _registerBloc.phoneStream);
  }

  Padding buildTexEmail() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: StreamBuilder(
          builder: (context, snapshot) => TextField(
            textInputAction: TextInputAction.next,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
                labelText: "Email",
                errorText: snapshot.hasError ? snapshot.error : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15)),
          ),
          stream: _registerBloc.emailStream,
        ));
  }

  StreamBuilder buildTexbirthday() {
    return StreamBuilder(
        builder: (context, snapshot) => TextField(
              controller: _birthdayController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.datetime,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Ngày sinh",
                  errorText: snapshot.hasError ? snapshot.error : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelStyle:
                      TextStyle(color: Color(0xff888888), fontSize: 15)),
            ),
        stream: _registerBloc.birthdayStream);
  }

  Row buildNameInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 16),
              child: StreamBuilder(
                  builder: (context, snapshot) => TextField(
                        autofocus: true,
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Họ",
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                  stream: _registerBloc.lastNameStream)),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 16),
              child: StreamBuilder(
                builder: (context, snapshot) => TextField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "Tên",
                      errorText: snapshot.hasError ? snapshot.error : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
                stream: _registerBloc.lastNameStream,
              )),
        ),
      ],
    );
  }

  Align buildTextBottom() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Chúng tôi sẽ giúp bạn tạo tài khoản mới",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              "sau một vài bước",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Text buildTextTop() {
    return Text(
      "Tham gia facebook",
      style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
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

  void onSignUpClicked() {
    ProgressLoading dialog = ProgressLoading();
    dialog.showLoading(context, "Loading...");
    if (_registerBloc.isValidInfo(
        _firstNameController.text,
        _lastNameController.text,
        _birthdayController.text,
        _emailController.text,
        _phoneController.text,
        _passController.text)) {
      _registerBloc.signUp(
          _firstNameController.text,
          _lastNameController.text,
          _birthdayController.text,
          _emailController.text,
          _phoneController.text,
          _passController.text, () {
        dialog.hideLoading();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },(){
        dialog.hideLoading();
      });
    }
  }
}

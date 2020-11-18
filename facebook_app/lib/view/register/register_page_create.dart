
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/helper/progress_dialog.dart';
import 'package:facebook_app/ultils/app_icons.dart';
import 'package:facebook_app/view/register/register_page_save.dart';
import 'package:facebook_app/view/register/register_page_step_6.dart';
import 'package:facebook_app/view/register/register_page_success.dart';
import 'package:facebook_app/viewmodel/sign_up_view_moldel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPageCreate extends StatefulWidget {
  UserEntity _user;

  RegisterPageCreate(this._user);

  @override
  State<StatefulWidget> createState() => _RegisterPageState(_user);
}

class _RegisterPageState extends State<RegisterPageCreate>
    with TickerProviderStateMixin {
  UserEntity _user;
  RegisterBloc _registerBloc = RegisterBloc();

  _RegisterPageState(this._user);

  ProgressLoading dialog = ProgressLoading();

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callBack());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Đang tạo tài khoản',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(),
    );
  }

  callBack() {
      dialog.showLoading(context, "Đang tạo tài khoản...");
      _registerBloc.signUp(_user, () {
        dialog.hideLoading();
        Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(
                builder: (context) => RegisterPageSuccess(_user)),
                (route) => false);
      }, () {
        dialog.hideLoading();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterPageSix.origin(_user)));
        });
      });
    }
}

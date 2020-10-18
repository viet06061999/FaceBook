import 'dart:async';

import 'package:facebook_app/src/blocs/auth_bloc.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/resources/register/register_page_save.dart';
import 'package:facebook_app/src/resources/register/register_page_step_six.dart';
import 'package:facebook_app/src/ultils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../progress_dialog.dart';

class RegisterPageCreate extends StatefulWidget {
  User _user;

  RegisterPageCreate(this._user);

  @override
  State<StatefulWidget> createState() => _RegisterPageState(_user);
}

class _RegisterPageState extends State<RegisterPageCreate>
    with TickerProviderStateMixin {
  User _user;
  bool isFirst = true;
  RegisterBloc _registerBloc = RegisterBloc();

  _RegisterPageState(this._user);

  ProgressLoading dialog = ProgressLoading();

  AnimationController _breathingController;
  var _breathe = 0.0;
  bool isVisible = false;
  bool isNavigation = false;
  var count = 0;

  @override
  void dispose() {
    super.dispose();
    _breathingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });

    _breathingController.addStatusListener((status) {
      setState(() {
        _breathe = _breathingController.value;
        if (_breathingController.duration.inMilliseconds == 1000 && isVisible)
          count++;
      });
    });

    _breathingController.forward();
  }

  Widget build(BuildContext context) {
    final size = 100.0 - 50.0 * _breathe;
    print(count);
    if (count == 10) {
      _breathingController.dispose();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(
                builder: (context) => RegisterPageSave(_user)),
            (route) => false);
      });
      count = 0;
    }
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
      body: Visibility(
        visible: isVisible,
        child: Center(
          child: Container(
            height: size,
            width: size,
            child: Icon(
              AppIcons.thumbs_up_alt,
              size: size - 20,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }

  callBack() {
    if (isFirst) {
      dialog.showLoading(context, "Đang tạo tài khoản...");
      _registerBloc.signUp(_user, () {
        dialog.hideLoading();
        setState(() {
          isVisible = true;
          count = 0;
          print('success');
        });
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
    isFirst = false;
  }
}

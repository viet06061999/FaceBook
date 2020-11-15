import 'package:facebook_app/data/source/local/user_local_data.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/view/home/home_page.dart';
import 'package:facebook_app/view/login/login_page.dart';
import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';

import 'data/repository/user_repository_impl.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

enum AuthStatus { notSignedIn, signIn, none }

class _RootPage extends State<RootPage> {
  AuthStatus status = AuthStatus.none;

  @override
  void initState() {
    super.initState();
    var userRepo =
        UserRepositoryImpl(inject<FirAuth>(), inject<UserLocalDatasource>());
    userRepo.getCurrentUser().then((value) {
      setState(() {
        status =
            value != null ? AuthStatus.signIn : AuthStatus.notSignedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AuthStatus.notSignedIn:
        return new LoginPage();
      case AuthStatus.signIn:
        return new HomePage();
      case AuthStatus.none:
        return new Container();
      default:
        return new Container();
    }
  }
}

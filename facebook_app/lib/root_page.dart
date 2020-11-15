import 'package:facebook_app/view/home/home_page.dart';
import 'package:facebook_app/view/login/login_page.dart';
import 'package:dartin/dartin.dart';
import 'package:facebook_app/helper/constants.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var email = inject<SpUtil>().getString(KEY_CURRENT_USER);
    print(email);
    setState(() {
      status = email != null ? AuthStatus.signIn : AuthStatus.notSignedIn;
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
    }
  }
}

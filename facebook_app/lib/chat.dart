import 'dart:io';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:facebook_app/view/chat/chat_detail/chat_detail.dart';
import 'package:facebook_app/view/chat/home/home.dart';
import 'package:facebook_app/view/chat/profile/profile.dart';
import 'package:facebook_app/widgets/app_theme.dart';

var routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/chatDetail": (BuildContext context) => ChatDetail(),
  "/profile": (BuildContext context) => ProfilePage(),
};

class App extends StatefulWidget {
  final HomeProvide provide;
  App(this.provide);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: AppTheme.textTheme,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}

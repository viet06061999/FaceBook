import 'package:facebook_app/src/resources/login_page.dart';
import 'package:facebook_app/src/resources/register/register_page_step_one.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/second': (context) => RegisterPageFirst(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

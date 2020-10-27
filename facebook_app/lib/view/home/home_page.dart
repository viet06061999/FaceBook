import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Home',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildButtonContinue()
              ],
            ),
          ),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Padding buildButtonContinue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed:() {
            FirAuth(FirebaseAuth.instance).signOut((){
              SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
              SharedPreferences.getInstance().then((value) {
                value.clear();
              });
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Đăng xuất",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Confirm Exit?',
            style: new TextStyle(color: Colors.black, fontSize: 20.0)),
        content: new Text(
            'Bạn chắc chắn muốn thoát ứng dụng?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              // this line exits the app.
              SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
            },
            child:
            new Text('Thoát', style: new TextStyle(fontSize: 18.0)),
          ),
          new FlatButton(
            onPressed: () => Navigator.pop(context), // this line dismisses the dialog
            child: new Text('Đóng', style: new TextStyle(fontSize: 18.0)),
          )
        ],
      ),
    ) ??
        false;
  }
}

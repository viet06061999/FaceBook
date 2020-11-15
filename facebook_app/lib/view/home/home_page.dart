import 'dart:io';

import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends PageProvideNode<HomeProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return HomePageTmp(mProvider);
  }
}

class HomePageTmp extends StatefulWidget {
  final HomeProvide provide;

  const HomePageTmp(this.provide);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePageTmp>
    with TickerProviderStateMixin<HomePageTmp>
    implements Presenter {
  HomeProvide _provide;

  //demo upload image: sửa lại khi create post
  File _image;
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    _provide = widget.provide;
  }

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
                buildButtonContinue(),
                //khi lam thì bỏ mấy cái demo này đi thay view mình làm vào

                //demo upload image
                Text('Selected Image'),
                _image != null
                    ? Image.asset(
                        _image.path,
                        height: 150,
                      )
                    : Container(height: 150),
                _image == null
                    ? RaisedButton(
                        child: Text('Choose File'),
                        onPressed: chooseFile,
                        color: Colors.cyan,
                      )
                    : Container(),
                _image != null
                    ? RaisedButton(
                        child: Text('Create Post'),
                        onPressed: uploadFile,
                        color: Colors.cyan,
                      )
                    : Container(),
                _image != null
                    ? RaisedButton(
                        child: Text('Clear Selection'),
                        onPressed: clearSelection,
                      )
                    : Container(),
                Text('Create Post'),
                _uploadedFileURL != null
                    ? Image.network(
                        _uploadedFileURL,
                        height: 150,
                      )
                    : Container(),
                //demo get list post
            Consumer<HomeProvide>(builder: (context, value, child) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: value.listPost.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Center(child: Text('Entry ${value.listPost[index].postId}')),
                    );
                  }
              );
            })
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
          onPressed: () {
            FirAuth(FirebaseAuth.instance).signOut(() {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
            content: new Text('Bạn chắc chắn muốn thoát ứng dụng?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Thoát', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                // this line dismisses the dialog
                child: new Text('Đóng', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  void onClick(String action) {
    // TODO: implement onClick
  }

  // demo upload image
  void clearSelection() {}

  Future uploadFile() async {
   _provide.uploadPost(Post.origin(), _image.path);
  }

  Future chooseFile() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _image = File(value.path);
      });
    });
  }
}

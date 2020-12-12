import 'package:flutter/cupertino.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/models/account_user.dart';

class AppBarNetworkRoundedImage extends StatefulWidget {
  final ChatProvide provide;

  AppBarNetworkRoundedImage({this.provide});

  @override
  State<StatefulWidget> createState() {
    return _AppBarNetworkRoundedImage(this.provide);
  }

}
class _AppBarNetworkRoundedImage extends State<AppBarNetworkRoundedImage> {
  final ChatProvide provide;
  _AppBarNetworkRoundedImage(this.provide);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(provide.userEntity.avatar),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}

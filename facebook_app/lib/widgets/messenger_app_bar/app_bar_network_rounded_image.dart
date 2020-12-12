import 'package:flutter/cupertino.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/routes/routes.dart';

class AppBarNetworkRoundedImage extends StatelessWidget {
  final String imageUrl;

  AppBarNetworkRoundedImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}

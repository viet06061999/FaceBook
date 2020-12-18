import 'package:flutter/cupertino.dart';
import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/routes/routes.dart';

class AppBarNetworkRoundedImage2 extends StatelessWidget {
  final String imageUrl;


  AppBarNetworkRoundedImage2({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
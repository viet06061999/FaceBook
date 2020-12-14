import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/data/model/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final HomeProvide provide;

  CommentWidget({this.comment, this.provide});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(comment.user.avatar),
                  radius: 20.0,
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(comment.user.firstName +' '+ comment.user.lastName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0)),
                      SizedBox(height: 5.0),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                                  comment.comment, style: TextStyle(fontSize: 15.0)
                              )
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 20.0),
        ],
      ),
    );
  }

}

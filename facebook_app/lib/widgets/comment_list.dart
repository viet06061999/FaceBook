import 'package:facebook_app/data/repository/user_repository_impl.dart';
import 'package:facebook_app/view/profile_friend.dart';
import 'package:facebook_app/view/profile_me.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/ultils/string_ext.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'infinite_scroll.dart';

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
                GestureDetector(
                  onTap: () {
                    if (comment.user.id ==
                        UserRepositoryImpl.currentUser.id) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMe()),
                      );
                    } else {
                      int status = provide.checkStatusFriend(comment.user.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileFriend(comment.user)),
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(comment.user.avatar),
                    radius: 20.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(

                        children: [
                          // InfiniteScroll(),
                          GestureDetector(
                            onTap: () {
                              if (comment.user.id ==
                                  UserRepositoryImpl.currentUser.id) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileMe()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileFriend(comment.user)),
                                );
                              }
                            },
                            child: Text(
                                comment.user.firstName +
                                    ' ' +
                                    comment.user.lastName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),
                          ),

                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child:Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text:comment.comment.getMyText(),
                                //textAlign: TextAlign.left,
                                linkStyle: TextStyle( fontSize: 15.0,color: Colors.black),
                              ),

                              // Text(comment.comment.getMyText(),
                              //     style: TextStyle(fontSize: 15.0)
                                 )),
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

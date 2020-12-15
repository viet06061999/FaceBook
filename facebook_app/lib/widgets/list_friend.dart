import 'dart:ui';
import 'dart:math';

import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/view/profile_friend.dart';
import 'package:facebook_app/viewmodel/friend_view_model.dart';
import 'package:facebook_app/viewmodel/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ListUserFriend extends StatefulWidget {
  final int maxFriends = 9999;
  final List<Friend> friends;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  // ListUserFriend(this.provide, this.friends, this.onImageClicked, this.onExpandClicked);
  ListUserFriend(
      {
        @required this.friends,
      @required this.onImageClicked,
      @required this.onExpandClicked,
      Key key,
      })
      : super(key: key);

  @override
  createState() => _ListUserFriendState();
}

@override
class _ListUserFriendState extends State<ListUserFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "danh sach",
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          backgroundColor: Colors.white,
        ),

        // var images = buildFriends();
        body: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.friends.length,
            itemBuilder: (context, index) {
              return buildFriend(widget.friends[index]);
            }));
  }

  List<Widget> buildFriends() {
    int numImages = widget.friends.length;
    print(widget.friends.length);
    return List<Widget>.generate(min(numImages, widget.maxFriends), (index) {
      Friend friend = widget.friends[index];

      // If its the last image
      if (index == widget.maxFriends - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxFriends;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: buildFriend(friend),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                buildFriend(friend),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: buildFriend(friend),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }

  Container buildFriend(Friend friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileFriend(friend.userSecond)),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(friend.userSecond.avatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      friend.userSecond.firstName +
                          " " +
                          friend.userSecond.lastName,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: Text(
                            "5 bạn chung",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return new Container(
                                      // height: 350.0,
                                      color: Color(0xFF737373),
                                      child: new Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              _createTile(
                                                  context,
                                                  'Xem bạn bè của ' +
                                                      friend.userSecond
                                                          .firstName +
                                                      " " +
                                                      friend
                                                          .userSecond.lastName,
                                                  Icon(
                                                    Icons.people_outline,
                                                    color: Colors.black,
                                                  ),
                                                  _action1,
                                                  friend.userSecond.id),
                                              _createTile(
                                                  context,
                                                  'Xem trang cá nhân của ' +
                                                      friend.userSecond
                                                          .firstName +
                                                      " " +
                                                      friend
                                                          .userSecond.lastName,
                                                  Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    color: Colors.black,
                                                  ),
                                                  _action1,
                                                  friend.userSecond.id),
                                              _createTile(
                                                  context,
                                                  'Chặn ' +
                                                      friend.userSecond
                                                          .firstName +
                                                      " " +
                                                      friend
                                                          .userSecond.lastName,
                                                  Icon(
                                                    Icons.block,
                                                    color: Colors.black,
                                                  ),
                                                  _action1,
                                                  friend.userSecond.id),
                                              _createTile(
                                                  context,
                                                  'Hủy kết bạn ' +
                                                      friend.userSecond
                                                          .firstName +
                                                      " " +
                                                      friend
                                                          .userSecond.lastName,
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.black,
                                                  ),
                                                  _action1,
                                                  friend.userSecond.id),
                                            ],
                                          )),
                                    );
                                  });
                            },
                            child: Container(
                              height: 40.0,
                              width: 45.0,
                              child: Icon(Icons.more_horiz),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile _createTile(BuildContext context, String name, Icon icon,
      Function action, String userId) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(userId);
      },
    );
  }

  _action1(String userId) {
    print(userId);
  }
}

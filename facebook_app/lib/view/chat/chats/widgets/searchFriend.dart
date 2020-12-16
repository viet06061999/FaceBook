import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/models/list_friend_model.dart';
import 'package:facebook_app/view/chat/people/widgets/conversation_item.dart';
import 'package:facebook_app/widgets/messenger_app_bar/messenger_app_bar.dart';

class searchFriend extends StatefulWidget {
  final ChatProvide _provide;

  searchFriend(this._provide);

  _searchFriendState createState() => _searchFriendState(_provide);
}

class _searchFriendState extends State<searchFriend> {
  ScrollController _controller;
  bool _isScroll = false;
  final ChatProvide _provide;

  _searchFriendState(this._provide);

  _scrollListener() {
    if (_controller.offset > 0) {
      this.setState(() {
        _isScroll = true;
      });
    } else {
      this.setState(() {
        _isScroll = false;
      });
    }
  }

  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMessengerAppBar(_isScroll),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child : Text(
                "Gợi ý",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                controller: _controller,
                itemBuilder: (context, index) {
                  return ConversationItem(
                    _provide,
                    _provide.users[index],
                  );
                },
                itemCount: _provide.users.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildMessengerAppBar(_isScroll) {
    return Container(
      height: 90.0,
      padding: EdgeInsets.only(right: 12.0, top: 16.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: _isScroll ? Colors.black12 : Colors.white,
          offset: Offset(0.0, 1.0),
          blurRadius: 10.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: InkWell(
                  onTap: () {
                    Routes.goBack(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 15.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Tin nhắn mới',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


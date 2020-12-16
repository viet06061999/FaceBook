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
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            _buildMessengerAppBar(_isScroll),
            _buildRootListView(),
          ],
        ),
      ),
    );
  }

  _buildMessengerAppBar(_isScroll) {
    return (MessengerAppBar(
      _provide,
      isScroll: _isScroll,
      title: 'Danh bạ',
      actions: <Widget>[
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: Icon(
            FontAwesomeIcons.solidAddressBook,
            size: 15.0,
          ),
        ),
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: Icon(
            FontAwesomeIcons.userPlus,
            size: 15.0,
          ),
        ),
      ],
    ));
  }

  _buildRootListView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        controller: _controller,
        itemBuilder: (context, index) {
          return ConversationItem(
            _provide,
            _provide.friends[index],
          );
        },
        itemCount: _provide.friends.length,
      ),
    );
  }
}

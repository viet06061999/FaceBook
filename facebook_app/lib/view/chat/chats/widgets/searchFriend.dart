import 'package:flutter/material.dart';
import 'package:facebook_app/models/popular_list.dart';
import 'package:facebook_app/view/chat/discovery/widgets/popular_item.dart';
import 'package:facebook_app/view/chat/discovery/widgets/stories_list.dart';
import 'package:facebook_app/view/chat/discovery/widgets/search_bar.dart';
import 'package:facebook_app/widgets/messenger_app_bar/messenger_app_bar.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';

class searchFriend extends StatefulWidget {
  final ChatProvide _provide;
  searchFriend(this._provide);

  _searchFriendState createState() => _searchFriendState(_provide);
}

class _searchFriendState extends State<searchFriend> {
  bool _isScroll = false;
  ScrollController _controller;
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: <Widget>[
            MessengerAppBar(
              _provide,
              isScroll: _isScroll,
              title: 'Discovery',
              actions: <Widget>[],
            ),
            _buildRootWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildRootWidget() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        controller: _controller,
        itemCount: popularList.length + 4,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              child: _buildSearchBar(),
            );
          } else if (index == 1) {
            return Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Recent',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SEE MORE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            );
          } else if (index == 2) {
            return Container(
              height: 100.0,
              child: StoriesList(),
            );
          } else if (index == 3) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Popular',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return PopularItem(popularItem: popularList[index - 4]);
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return (Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0), child: SearchBar()));
  }
}

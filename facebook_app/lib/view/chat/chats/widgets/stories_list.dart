import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/view/chat/chats/list_friend.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/models/list_friend_model.dart';

class StoriesList extends StatefulWidget {
  final ChatProvide provide;
  StoriesList(this.provide);
  @override
  _StoriesListState createState() => _StoriesListState(provide);
}

class _StoriesListState extends State<StoriesList> {
  final ChatProvide provide;
  _StoriesListState(this.provide);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return AddToYourStoryButton();
        } else {
          return StoryListItem(
              provide,
              provide.friends);
        }
      },
      itemCount: provide.friends.length,
    );
  }
}

class StoryListItem extends StatefulWidget {
  final List<Friend> friendItem;
  final ChatProvide provide;
  StoryListItem(this.provide, this.friendItem);

  @override
  State<StatefulWidget> createState() {
    return _StoryListItemState(friendItem);
  }
}

class _StoryListItemState extends State<StoryListItem> {
  final List<Friend> friendItem;
  _StoryListItemState(this.friendItem);
  _buildBorder() {
    if (true) {
      return Border.all(color: Colors.grey.shade300, width: 3);
    } else {
      return Border.all(color: Colors.blue, width: 3);
    }
  }

  _getTextStyle() {
    if (true) {
      return _viewedStoryListItemTextStyle();
    } else {
      return _notViewedStoryListItemTextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: _buildBorder(),
                ),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                      image: NetworkImage(friendItem[0].userSecond.avatar),  // ảnh đại diện
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: 60.0,
                child: Text(
                  friendItem[0].userSecond.firstName + " " + friendItem[0].userSecond.lastName,         // tên bạn
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: _getTextStyle(),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.0)
        ],
      ),
    );
  }
}

class AddToYourStoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    // borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Icon(
                    Icons.add,
                    size: 35.0,
                  )),
              SizedBox(height: 8.0),
              Text('Your story', style: _viewedStoryListItemTextStyle()),
            ],
          ),
          SizedBox(width: 12.0)
        ],
      ),
    );
  }
}

_notViewedStoryListItemTextStyle() {
  return TextStyle(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
}

_viewedStoryListItemTextStyle() {
  return TextStyle(fontSize: 12, color: Colors.grey);
}

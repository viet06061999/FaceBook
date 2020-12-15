import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/widgets/messenger_app_bar/app_bar_network_rounded_image.dart';
import 'package:facebook_app/widgets/messenger_app_bar_action/messenger_app_bar.dart';

const ListYourFriendChat = [
  'Nice to meet you!',
  'Hello',
  " zzz",
];
const ListYourChat = [
  'Nice to meet you!',
  'Nice to meet you!',
  'Hiaaaaaaaaaaa',
];

class ChatDetail extends StatefulWidget {
  final Friend friend;
  final ChatProvide provide;
  ChatDetail(this.provide, this.friend){
    provide.getChatDetail(friend: friend.userSecond);
  }
  _ChatDetailState createState() => _ChatDetailState(provide, friend);
}

class _ChatDetailState extends State<ChatDetail> {
  final Friend friend;
  final ChatProvide provide;
  _ChatDetailState(this.provide, this.friend);
  final _isScroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            _buildAppBar(friend),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index < ListYourFriendChat.length) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 2.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          AppBarNetworkRoundedImage(
                              //provide.getConservations(friend.userSecond);
                              imageUrl: friend.userSecond.avatar),
                          SizedBox(width: 15.0),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              ListYourFriendChat[index],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    );
                  } 
                  else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 2.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(width: 55.0),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              ListYourChat[index-ListYourFriendChat.length],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
                itemCount:  ListYourFriendChat.length + ListYourChat.length,
              ),
            ),
            _buildBottomChat(friend),
          ],
        ),
      ),
    );
  }

  _buildAppBar(Friend friend) {
    return MessengerAppBarAction(
      isScroll: _isScroll,
      isBack: true,
      title: friend.userSecond.firstName +" "+ friend.userSecond.lastName,
      imageUrl: friend.userSecond.avatar,
      subTitle: 'Không hoạt động',
      actions: <Widget>[
        Icon(
          FontAwesomeIcons.phoneAlt,
          color: Colors.lightBlue,
          size: 20.0,
        ),
        Icon(
          FontAwesomeIcons.infoCircle,
          color: Colors.lightBlue,
          size: 20.0,
        ),
      ],
    );
  }

  _buildBottomChat(Friend friend) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.image,
                size: 25.0,
                color: Colors.lightBlue,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'Aa',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    suffixIcon: Icon(
                      FontAwesomeIcons.solidSmileBeam,
                      size: 25.0,
                      color: Colors.lightBlue,
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.solidThumbsUp,
                size: 25.0,
                color: Colors.lightBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}

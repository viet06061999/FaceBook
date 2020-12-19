import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/view/chat/chats/widgets/searchFriend.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/models/list_friend_model.dart';
import 'package:facebook_app/view/chat/chats/widgets/conversation_item.dart';
import 'package:facebook_app/view/chat/chats/widgets/search_bar.dart';
import 'package:facebook_app/view/chat/chats/widgets/stories_list.dart';
import 'package:facebook_app/widgets/messenger_app_bar/messenger_app_bar.dart';
import 'package:facebook_app/base/base.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/view/chat/chats/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ListFriend extends PageProvideNode<ChatProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return ListFriendTmp(mProvider);
  }
}

class ListFriendTmp extends StatefulWidget {
  final ChatProvide provide;

  ListFriendTmp(this.provide){
    // provide.getConservations(provide.userEntity);
  }
  @override
  State<StatefulWidget> createState() => _ListFriendState(provide);
}

class _ListFriendState extends State<ListFriendTmp>
    with SingleTickerProviderStateMixin{
  ChatProvide _provide;
  _ListFriendState(this._provide);

  ScrollController _controller;
  bool _isScroll = false;
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
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvide>(builder: (context, value, child){
      return  NotificationListener<OverscrollIndicatorNotification>(
        // onNotification: (overscroll) {
        //   overscroll.disallowGlow();
        // },
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _buildMessengerAppBar(_isScroll),
              _buildRootListView(value),
            ],
          ),
        ),
      );
    },);
  }

  _buildMessengerAppBar(_isScroll) {
    File imageFile;
    void _openCamera(BuildContext context) async {
      var camPicture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        imageFile = camPicture;
      });

      Navigator.of(context).pop();
    }

    Widget _imageView() {
      if (imageFile == null) {
        return Text("No Image Selected");
      } else {
        return Image.file(imageFile, width: 400, height: 400);
      }
    }
    return  (MessengerAppBar(
        _provide,
        isScroll: _isScroll,
        title: 'Chat',
        actions: <Widget>[
          Row (
            children: <Widget>[
              // InkWell(
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       // builder: (context) => AccessCamera(),
              //       builder: (context) => Camera(),
              //
              //     ),
              //   ),
              //
              //   child: Container(
              //     margin: const EdgeInsets.only( right: 15.0),
              //     width: 33.0,
              //     height: 33.0,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Colors.grey.shade200,
              //     ),
              //     child: Icon(
              //       FontAwesomeIcons.camera,
              //       size: 15.0,
              //     ),
              //   ),
              // ),

              IconButton(
                icon: Icon(

                  FontAwesomeIcons.camera,
                  size: 25.0,
                  color: Colors.lightBlue,
                ),
                onPressed: () {
                  // _showDialog(context);
                  _openCamera(context);
                },


              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchFriend(_provide),
                  ),
                ),
                child: Container(
                  width: 33.0,
                  height: 33.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 15.0,
                  ),
                ),
              )
            ],
          )



        ])
    );
  }

  _buildRootListView(ChatProvide value) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        controller: _controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            test(value.conservations.length);
            return _buildSearchBar(value);
          } else if (index == 1) {
            return _buildStoriesList(value);
          } else {
            return ConversationItem(value.conservations[index-2]);
          }
        },
        itemCount: value.conservations.length + 2,
      ),
    );
  }

  _buildSearchBar(ChatProvide provide) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SearchBar(provide),
    );
  }

  _buildStoriesList(ChatProvide provide) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 16.0),
      child: StoriesList(provide),
    );
  }
}

void test(int kiemtra) {
  print("hihihi $kiemtra");
}

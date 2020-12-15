import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/widgets/messenger_app_bar/app_bar_network_rounded_image.dart';
import 'package:facebook_app/widgets/messenger_app_bar_action/messenger_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/data/model/conservation.dart';

class ChatDetailV3 extends PageProvideNode<ChatProvide> {
  final Conservation conservation;

  ChatDetailV3(this.conservation);

  @override
  Widget buildContent(BuildContext context) {
    return ChatDetailV3Tmp(mProvider, conservation);
  }
}

class ChatDetailV3Tmp extends StatefulWidget {
  final Conservation conservation;
  final ChatProvide provide;

  ChatDetailV3Tmp(this.provide, this.conservation){
    provide.getChatDetail(conservation: conservation);
  }

  @override
  State<StatefulWidget> createState() => _ChatDetailState(conservation);
}

class _ChatDetailState extends State<ChatDetailV3Tmp>
    with SingleTickerProviderStateMixin {
  ChatProvide _provide;
  final Conservation conservation;

  _ChatDetailState(this.conservation);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    var friend = conservation.checkFriend(_provide.userEntity.id);
    return Scaffold(body: Consumer<ChatProvide>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              buildAppBar(conservation),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print('vaof list view roi');
                    // print('size  ${value.messages.length}');
                    if (value.messages[value.messages.length-index-1].from.id ==
                        friend.id) {
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
                                //value.getConservations(friend.userSecond);
                                imageUrl: friend.avatar),
                            SizedBox(width: 15.0),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Text(
                                value.messages[value.messages.length-index-1].message,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
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
                                value.messages[value.messages.length-index-1].message,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              _buildBottomChat(conservation),
            ],
          ),
        );
      },
    ));
  }

  buildAppBar(Conservation conservation) {
    var friend = conservation.checkFriend(_provide.userEntity.id);
    return MessengerAppBarAction(
      isScroll: true,
      isBack: true,
      title: friend.firstName + " " + friend.lastName,
      imageUrl: friend.avatar,
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

  _buildBottomChat(Conservation conservation) {
    var friend = conservation.checkFriend(_provide.userEntity.id);
    var myController = TextEditingController();
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
                controller: myController,
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
              onPressed: () {
                Text mess = Text(myController.text);
                if(mess.data != null && mess.data != "" ) {
                  _provide.sendMessage(friend,
                      content: myController.text);
                }
              },
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

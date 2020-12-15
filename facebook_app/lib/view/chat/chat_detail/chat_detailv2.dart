import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/widgets/messenger_app_bar/app_bar_network_rounded_image.dart';
import 'package:facebook_app/widgets/messenger_app_bar_action/messenger_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ChatDetail extends PageProvideNode<ChatProvide> {
  final Friend friend;

  ChatDetail(this.friend);

  @override
  Widget buildContent(BuildContext context) {
    return ChatDetailTmp(mProvider, friend);
  }
}

class ChatDetailTmp extends StatefulWidget {
  final Friend friend;
  final ChatProvide provide;

  ChatDetailTmp(this.provide, this.friend) {
    provide.getChatDetail(friend: friend.userSecond);
  }

  @override
  State<StatefulWidget> createState() => _ChatDetailState(friend);
}

class _ChatDetailState extends State<ChatDetailTmp>
    with SingleTickerProviderStateMixin {
  ChatProvide _provide;
  Friend friend;
  // ScrollController _controller;
  // bool _isScroll = false;
  // _scrollListener() {
  //   if (_controller.offset > 0) {
  //     this.setState(() {
  //       _isScroll = true;
  //     });
  //   } else {
  //     this.setState(() {
  //       _isScroll = false;
  //     });
  //   }
  // }
  _ChatDetailState(this.friend);

  @override
  void initState() {
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    super.initState();
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ChatProvide>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              buildAppBar(friend),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: value.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (value.messages[value.messages.length-index-1].from.id ==
                        friend.userSecond.id) {
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
              _buildBottomChat(friend),
            ],
          ),
        );
      },
    ));
  }

  buildAppBar(Friend friend) {
    return MessengerAppBarAction(
      isScroll: true,
      // isScroll: _isScroll,
      isBack: true,
      title: friend.userSecond.firstName + " " + friend.userSecond.lastName,
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
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 25.0,
                    color: Colors.lightBlue,
                  ),
                  onPressed: () {},

                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.image,
                    size: 25.0,
                    color: Colors.lightBlue,
                  ),
                  onPressed: () {
                    loadAssets();
                  },
                )
              ],



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
                  _provide.sendMessage(friend.userSecond,
                      content: myController.text);
                }
              },
              icon: Icon(
                // FontAwesomeIcons.solidThumbsUp,
                FontAwesomeIcons.paperPlane,
                size: 25.0,
                color: Colors.lightBlue,
              ),
            ),
          )
        ],
      ),
    );
  }

  loadAssets() {
    String error = 'No Error Dectected';

    try {
      MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        // selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      ).then((value) {
        for (int i = 0; i < value.length; i++) {
          FlutterAbsolutePath.getAbsolutePath(value[i].identifier)
              .then((value) =>
              setState(() {
                print(value);
                // pathImages.add(value);
              }));
        }
      });
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
  }
// Future<File> pickImage(ImageSource source) async{
//   File testImage = await ImagePicker.pickImage(source: source);
//   setState(() {
//     pickedImage = testImage;
//   });
// }

}

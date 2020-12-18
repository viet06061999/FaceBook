import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/friend.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/view/chat/chats/widgets/conversation_item.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/widgets/messenger_app_bar/AppBarNetworkRoundedImage2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/widgets/messenger_app_bar/app_bar_network_rounded_image.dart';
import 'package:facebook_app/widgets/messenger_app_bar_action/messenger_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/data/model/conservation.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String content = "";
  var myController = TextEditingController();
  String cont="";
  ChatProvide _provide;
  final Conservation conservation;
  _ChatDetailState(this.conservation);

  @override
  void initState() {
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
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: value.messages.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    if(index==value.messages.length){
                      return _buildNewFriend(friend);
                    }
                    else if (value.messages[value.messages.length-index-1].from.id ==
                        friend.id) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 2.0,
                        ),
                        child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text: getMyText(getText(value.messages[value.messages.length-index-1].message)),
                              //  textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0),
                                linkStyle: TextStyle(color: Colors.black),
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
                          //crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text: getMyText(getText(value.messages[value.messages.length-index-1].message)),
                                style: TextStyle(fontSize: 14.0),
                                linkStyle: TextStyle(color: Colors.black),
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
  _buildNewFriend(UserEntity friend) {
    return Container(
      padding: EdgeInsets.only(top: 100,bottom: 80),

      child: Column(
          children: <Widget>[
            AppBarNetworkRoundedImage2(
              imageUrl: friend.avatar,
            ),
            Container(
              child: Text(
                friend.firstName+" "+friend.lastName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ]
      ),
    );
  }
  buildAppBar(Conservation conservation) {
    var friend = conservation.checkFriend(_provide.userEntity.id);
    return MessengerAppBarAction(
      isScroll: true,
      // isScroll: _isScroll,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            // child: Row(
            //   children: <Widget>[
            //     IconButton(
            //       icon: Icon(
            //         FontAwesomeIcons.camera,
            //         size: 25.0,
            //         color: Colors.lightBlue,
            //       ),
            //       onPressed: () {},
            //
            //     ),
            //     IconButton(
            //       icon: Icon(
            //         FontAwesomeIcons.image,
            //         size: 25.0,
            //         color: Colors.lightBlue,
            //       ),
            //       onPressed: () {
            //         loadAssets();
            //       },
            //     )
            //   ],
            // ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    int n = myController.text.length;
                    if(myController.text[n-1]==" "&&n>=2) {
                      cont = myController.text;
                      cont = getMyTextSpace(cont);
                      if(myController.text!=cont){
                        myController.text=cont;
                        myController.selection = TextSelection.fromPosition(
                          TextPosition(offset: myController.text.length),
                        );
                      }
                    }
                    content = text;
                    content = text;
                  });
                },
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
                String mess = myController.text;
                if(mess != null && mess != "" ) {
                  _provide.sendMessage(friend,
                      content: content);
                  myController.text="";
                  content ="";
                }
                else {
                  _provide.sendMessage(friend,
                      content: "👍");
                }
              },
              icon: Icon(
                // FontAwesomeIcons.solidThumbsUp,
                content.isEmpty ? FontAwesomeIcons.solidThumbsUp :
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

String getText(String message) {
  int n = message.length;
  int dem = 0;
  for(int i = 0; i < n; i++) {
    if (i == n - 1) {
      dem++;
    }
    else {
      int j = message.substring(i + 1, n).indexOf(" ");
      if (j == -1) {
        dem++;
      }
      else {
        if (j >= 30) {
          //xuong dong
          message = message.substring(0, i + 30 - dem + 1) + "\n" +
              message.substring(i + 30 - dem + 1, n);
          dem = 0;
          n += 1;
          i += 30 - dem;
        }
        else if (j >= 30 - dem) {
          if (message[i] == " ") {
            message =
                message.substring(0, i) + "\n" + message.substring(i + 1, n);
            dem = 0;
          }
          else {
            message = message.substring(0, i) + "\n" +
                message.substring(i, n);
            dem = 0;
            i++;
            n++;
          }
        }
        else {
          dem++;
        }
      }
    }
    // đủ độ dài 30
    if (dem == 30) {
      message = message.substring(0, i + 2) + "\n" + message.substring(i + 2, n);
      n++;
      i++;
      dem = 0;
    }
  }
  return message;
}
String getMyText(String myController) {
  String s = myController;
  int n = s.length;
  for(int i=0;i<n;i++){
    // icon buồn
    if(i<n-1&&s[i]==":"&&s[i+1]=="(") {
      s = s.substring(0,i) + "😞"+ s.substring(i+2,n);
      i++;
    } // icon fine
    else if(i<n-1&&s[i]==":"&&s[i+1]==")") {
      s = s.substring(0,i) + "🙂"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==":"&&s[i+1]=="D") {
      s = s.substring(0,i) + "😃"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==":"&&s[i+1]=="P") {
      s = s.substring(0,i) + "😛"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==":"&&s[i+1]=="O") {
      s = s.substring(0,i) + "😮"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==":"&&s[i+1]=="/") {
      s = s.substring(0,i) + "😕"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==":"&&s[i+1]=="*") {
      s = s.substring(0,i) + "😘"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]=="<"&&s[i+1]=="3") {
      s = s.substring(0,i) + "❤"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]=="="&&s[i+1]=="b"){
      s = s.substring(0,i) + "👍"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-1&&s[i]==";"&&s[i+1]==")"){
      s = s.substring(0,i) + "😉"+ s.substring(i+2,n);
      i++;
    }
    else if(i<n-5&&s[i]==":"&&s[i+1]=="p"&&s[i+2]=="o"&&s[i+3]=="o"&&s[i+4]=="p"&&s[i+5]==":"){
      s = s.substring(0,i) + "💩"+ s.substring(i+6,n);
      i++;
    }
    // code thêm thì làm theo form trên
  }
  return s;
}

String getMyTextSpace(String text) {
  String s = text;
  int n = s.length;
  if(n>=3&&s[n-3]==":"&&s[n-2]=="(") {
    if(n>=4) s = s.substring(0,n-3) + "😞 ";
    else{
      s = s.substring(0,n-3) + "😞 ";
    }
  } // icon fine
  else if(n>=3&&s[n-3]==":"&&s[n-2]==")") {
    if(n>=4) s = s.substring(0,n-3) + "🙂 ";
    else{
      s = s.substring(0,n-3) + "🙂 ";
    }
  }
  else if(n>=3&&s[n-3]==":"&&s[n-2]=="D") {
    if(n>=4)s = s.substring(0,n-3) + "😃 ";
    else{
      s = s.substring(0,n-3) + "😃 ";
    }
  }
  else if(n>=3&&s[n-3]==":"&&s[n-2]=="P") {
    if(n>=4)s = s.substring(0,n-3) + "😛 ";
    else{
      s = s.substring(0,n-3) + "😛 ";
    }
  }
  else if(n>=3&&s[n-3]==":"&&s[n-2]=="O") {
    if(n>=4)s = s.substring(0,n-3) + "😮 ";
    else{
      s = s.substring(0,n-3) + "😮 ";
    }
  }
  else if(n>=3&&s[n-3]==":"&&s[n-2]=="/") {
    if(n>=4)s = s.substring(0,n-3) + "😕 ";
    else{
      s = s.substring(0,n-3) + "😕 ";
    }
  }
  else if(n>=3&&s[n-3]==":"&&s[n-2]=="*") {
    if(n>=4)s = s.substring(0,n-3) + "😘 ";
    else{
      s = s.substring(0,n-3) + "😘 ";
    }
  }
  else if(n>=3&&s[n-3]=="<"&&s[n-2]=="3") {
    if(n>=4)s = s.substring(0,n-3) + "❤ ";
    else{
      s = s.substring(0,n-3) + "❤ ";
    }
  }
  else if(n>=3&&s[n-3]=="="&&s[n-2]=="b"){
    if(n>=4)s = s.substring(0,n-3) + "👍 ";
    else{
      s = s.substring(0,n-3) + "👍 ";
    }
  }
  else if(n>=3&&s[n-3]==";"&&s[n-2]==")"){
    if(n>=4)s = s.substring(0,n-3) + "😉 ";
    else{
      s = s.substring(0,n-3) + "😉 ";
    }
  }
  else if(n>=7&&s[n-7]==":"&&s[n-6]=="p"&&s[n-5]=="o"&&s[n-4]=="o"&&s[n-3]=="p"&&s[n-2]==":"){
    if(n>=8) s = s.substring(0,n-7) + "💩 ";
    else{
      s = s.substring(0,n-7) + "💩 ";
    }
  }
  // code thêm thì làm theo form trên

  return s;
}
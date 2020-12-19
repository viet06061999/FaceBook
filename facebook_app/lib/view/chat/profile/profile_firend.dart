import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/data/model/conservation.dart';
import 'package:facebook_app/view/chat/profile/profile_firend_compact.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfilePageFriend extends PageProvideNode<ChatProvide> {
  final Conservation conservation;
  ProfilePageFriend(this.conservation);
  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageFriendTmp(mProvider, conservation);
  }
}
class ProfilePageFriendTmp extends StatefulWidget {
  final Conservation conservation;
  final ChatProvide provide;
  const ProfilePageFriendTmp(this.provide, this.conservation);

  @override
  State<StatefulWidget> createState() => _ProfilePageFriendState(conservation);
}


class _ProfilePageFriendState extends State<ProfilePageFriendTmp>
    with SingleTickerProviderStateMixin {
  ChatProvide _provide;
  final Conservation conservation;
  _ProfilePageFriendState(this.conservation);
  bool _isScroll = false;
  ScrollController _controller;

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
    var friend = conservation.checkFriend(_provide.userEntity.id);
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Center(
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                              image: NetworkImage(friend.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          friend.firstName +" "+ friend.lastName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // alignment: Alignment.centerRight,
                        children: <Widget>[

                          SizedBox(width: 10.0),
                          GestureDetector(
                              onTap: (){
                                showMaterialModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ProfilePageFriendCompact(conservation),
                                );
                              },
                            child: Center(

                              child: Container(

                                padding: EdgeInsets.symmetric(

                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(

                                  color: Colors.grey[300],
                                  // borderRadius: BorderRadius.circular(30.0)),
                                  shape: BoxShape.circle,
                                ),

                                child: Icon(Icons.person),

                              ),

                            )
                          ),
                        ],
                      ),
                      _buildSettingItem3('Chủ đề', '', false, FontAwesomeIcons.arrowAltCircleUp),
                      _buildSettingItem3('Biểu tượng cảm xúc', '', false, FontAwesomeIcons.arrowAltCircleUp),
                      _buildSettingItem('yyyyyyyyy', '', false,FontAwesomeIcons.users,Colors.purpleAccent,Colors.white),
                      _buildSettingItem('Tin nhắn chờ', '', false,FontAwesomeIcons.facebookMessenger,Colors.lightBlueAccent,Colors.white),
                      _buildTitleSetting('hành động khác'),
                      // _buildSettingItem2('Trang thái hoạt động', 'Bật', false,FontAwesomeIcons.userMinus,Colors.lightGreenAccent.shade400),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
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
              Container(
                child: Text(
                  '',
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
                    Icons.more_vert,

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

  _buildTitleSetting(title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
          )),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
      ),
    );
  }

  _buildSettingItem(title, subtitle, isBorderBottom, icon,color1,color2) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      padding: EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: isBorderBottom ? 0.5 : 0.0,
              color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
            ),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: color1,
                  // image: DecorationImage(
                  //   image: NetworkImage(provide.userEntity.avatar),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Icon(
                  icon,
                  //FontAwesomeIcons.chevronRight,
                  color: color2,
                  size: 18.0,
                ),
              ),
              // Icon(
              //   icon,
              //   //FontAwesomeIcons.chevronRight,
              //   color: Colors.grey.shade500,
              //   size: 18.0,
              // ),
              SizedBox(width: 10.0),
              Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(width: 10.0),
              // Icon(
              //   FontAwesomeIcons.chevronRight,
              //   color: Colors.grey.shade500,
              //   size: 18.0,
              // )
            ],
          )
        ],
      ),
    );
  }
}

_buildSettingItem2(title, subtitle, isBorderBottom, icon,color1) {
  return Container(
    margin: EdgeInsets.only(left: 16.0),
    padding: EdgeInsets.only(
      top: 12.0,
      bottom: 12.0,
      right: 10.0,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: isBorderBottom ? 0.5 : 0.0,
            color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
          ),
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: color1,
                // image: DecorationImage(
                //   image: NetworkImage(provide.userEntity.avatar),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Icon(
                icon,
                //FontAwesomeIcons.chevronRight,
                color: Colors.white,
                size: 18.0,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    )
                ),
                SizedBox(width: 10.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

_buildSettingItem3(title, subtitle, isBorderBottom, icon2) {
  return Container(
    margin: EdgeInsets.only(left: 16.0),
    padding: EdgeInsets.only(
      top: 12.0,
      bottom: 12.0,
      right: 10.0,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: isBorderBottom ? 0.5 : 0.0,
            color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
          ),
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            // Container(
            //   width: 35,
            //   height: 35,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(80.0),
                // color: color1,
                // image: DecorationImage(
                //   image: NetworkImage(provide.userEntity.avatar),
                //   fit: BoxFit.cover,
            //     // ),
            //   ),
              // child: Icon(
              //   icon1,
              //   //FontAwesomeIcons.chevronRight,
              //   color: Colors.white,
              //   size: 18.0,
            //   // ),
            // ),
            SizedBox(width: 10.0),
            Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                )
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15.0,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(
              icon2,
              color: Colors.grey.shade300,
              size: 18.0,
            )
          ],
        )
      ],
    ),
  );
}
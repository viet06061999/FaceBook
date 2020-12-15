import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/routes/routes.dart';

class ProfilePage extends PageProvideNode<ChatProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageTmp(mProvider);
  }
}
class ProfilePageTmp extends StatefulWidget {
  final ChatProvide provide;
  const ProfilePageTmp(this.provide);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePageTmp>
    with SingleTickerProviderStateMixin {
  ChatProvide provide;
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
    provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
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
                              image: NetworkImage(provide.userEntity.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          provide.userEntity.firstName +" " +  provide.userEntity.lastName,
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
                      _buildSettingItem3('Chế độ bóng tối', '', false,FontAwesomeIcons.arrowLeft,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem3('Chuyển tài khoản', '', false,FontAwesomeIcons.arrowLeft,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Tin nhắn chờ', '', false,FontAwesomeIcons.arrowLeft),
                      _buildTitleSetting('Trang cá nhân'),
                      _buildSettingItem2('Trang thái hoạt động', 'Bật', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem2('Tên người dùng', provide.userEntity.email, false,FontAwesomeIcons.arrowLeft),
                      _buildTitleSetting('Tuỳ chọn'),
                      _buildSettingItem('Quyền riêng tư', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Âm thanh & thông báo', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Trình tiết kiệm dữ liệu', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Tin', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('SMS', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Danh bạ thư điện thoại', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Ảnh & phương tiện', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem3('Bong bóng chat', '', false,FontAwesomeIcons.arrowLeft,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Cập nhật ứng dụng', '', false,FontAwesomeIcons.arrowLeft),
                      _buildTitleSetting('Tài khoản'),
                      _buildSettingItem('Cài đặt tài khoản', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Báo cáo vấn đề kỹ thuật', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Trợ giúp', '', false,FontAwesomeIcons.arrowLeft),
                      _buildSettingItem('Pháp lý và chính sách', '', false,FontAwesomeIcons.arrowLeft),
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
                  'Profile',
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
                // Container(
                //   padding: EdgeInsets.only(left: 20.0),
                //   child: Icon(
                //     FontAwesomeIcons.camera,
                //     color: Colors.black,
                //     size: 20.0,
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.only(left: 20.0),
                //   child: Icon(
                //     FontAwesomeIcons.solidEdit,
                //     color: Colors.black,
                //     size: 20.0,
                //   ),
                // ),
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

  _buildSettingItem(title, subtitle, isBorderBottom, icon) {
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
              Icon(
                icon,
                //FontAwesomeIcons.chevronRight,
                color: Colors.grey.shade500,
                size: 18.0,
              ),
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

_buildSettingItem2(title, subtitle, isBorderBottom, icon) {
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
            Icon(
              icon,
              //FontAwesomeIcons.chevronRight,
              color: Colors.grey.shade500,
              size: 18.0,
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

_buildSettingItem3(title, subtitle, isBorderBottom, icon1, icon2) {
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
            Icon(
              icon1,
              //FontAwesomeIcons.chevronRight,
              color: Colors.grey.shade500,
              size: 18.0,
            ),
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
              color: Colors.grey.shade500,
              size: 18.0,
            )
          ],
        )
      ],
    ),
  );
}
import 'package:facebook_app/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/data/model/notification/notification_friend.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationApp notification;
  final UserEntity userEntity;

  NotificationWidget({this.notification, this.userEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(notification.userFirst.avatar),
                radius: 35.0,
              ),
              SizedBox(width: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getContent(),
                  Text(notification.updateTime,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.more_horiz),
              Text(''),
            ],
          )
        ],
      ),
    );
  }

  Widget getContent() {
    return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            children: [
          TextSpan(
              text:
                  '${notification.userFirst.firstName} ${notification.userFirst.lastName}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: notification.getContent(userId: userEntity.id))
        ]));
  }
}

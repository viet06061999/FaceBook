import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/widgets/photo_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'comment_widget.dart';

// class reset {
//   void fix(String text1){
//     int n = text1.length;
//     for(int i=0;i< n; i++){
//         if(text1[i]=='.'){
//           text1 = text1.substring(0,i+1);
//         }
//     }
//   }
// }
class PostWidget extends StatelessWidget {
  final Post post;
  final HomeProvide provide;

  PostWidget({this.post, this.provide});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[400],
            width: MediaQuery.of(context).size.width,
            height: 11.0,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(post.owner.avatar),
                  radius: 20.0,
                ),
                SizedBox(width: 7.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(post.owner.firstName + ' ' + post.owner.lastName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(height: 5.0),
                    Text(fix(post.modified))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text(post.described, style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 10.0),
          buildImages(context),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: 15.0, color: Colors.blue),
                    Text(' ${post.likes.length}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${post.comments.length} comments'),
                    // Text('${post.shares} shares'), // so luong share
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 30.0),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Consumer<HomeProvide>(builder: (key, value, child) {
                  return FlatButton(
                    onPressed: () => {value.updateLike(post)},
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(FontAwesomeIcons.thumbsUp,
                            size: 20.0,
                            color: !post.isLiked ? Colors.grey : Colors.blue),
                        SizedBox(width: 5.0),
                        Text(
                          'Like',
                          style: TextStyle(
                              fontSize: 14,
                              color: !post.isLiked ? Colors.grey : Colors.blue),
                        )
                      ],
                    ),
                  );
                }),
                FlatButton(
                  onPressed: () => {
                    showMaterialModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CreateCommentWidget(
                        provide: provide,
                        post: post,
                      ),
                    )
                  },
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                      SizedBox(width: 5.0),
                      Text('Comment', style: TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.share, size: 20.0),
                    SizedBox(width: 5.0),
                    Text('Share', style: TextStyle(fontSize: 14.0)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Visibility buildImages(BuildContext context) {
    if (post.images.length == 1) {
      return Visibility(visible: true, child: Image.network(post.images[0]));
    } else if (post.images.length % 2 == 0) {
      return Visibility(
        visible: post.images.length > 0,
        child: PhotoGrid(
          imageUrls: post.images,
          onImageClicked: (i) => print('Image $i was clicked!'),
          onExpandClicked: () => print('Expand Image was clicked'),
          maxImages: 4,
        ),
      );
    } else {
      return Visibility(
          visible: true,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2 - 4,
                  child: Image.network(post.images[0], fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2 - 4,
                      child: Image.network(post.images[1], fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2 - 4,
                    child: Image.network(post.images[2], fit: BoxFit.cover),
                  ),
                ],
              )
            ],
          ));
    }
  }

  String fix(String text1) {
    var now = (new DateTime.now()).millisecondsSinceEpoch;
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime baiDang = format.parse(text1);
    var timeago = baiDang.millisecondsSinceEpoch;
    var timeagov1 = (now - timeago) / 1000;
    timeagov1 = (timeagov1 / 60 + 1);
    if (timeagov1 < 60) {
      String a = timeagov1.toStringAsFixed(0);
      return "$a phút";
    } else if (timeagov1 < 60 * 24) {
      String a = (timeagov1 / 60).toStringAsFixed(0);
      return "$a giờ";
    } else if (timeagov1 < 60 * 24 * 30) {
      String a = (timeagov1 / (60 * 24)).toStringAsFixed(0);
      return "$a ngày";
    } else {
      return "1 tháng trước";
    }
  }
}

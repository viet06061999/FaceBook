
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/video.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/widgets/photo_grid.dart';

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
                    Text(post.owner.firstName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(height: 5.0),
                    Text(post.modified)
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
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: 20.0,
                        color: !post.isLiked ? Colors.grey : Colors.blue),
                    SizedBox(width: 1.0),
                    Consumer<HomeProvide>(builder: (key, value, child) {
                      return TextButton(
                          onPressed: () {
                            value.updateLike(post);
                          },
                          child: Text(
                            'Like',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    !post.isLiked ? Colors.grey : Colors.blue),
                          ));
                    }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                    SizedBox(width: 5.0),
                    Text('Comment', style: TextStyle(fontSize: 14.0)),
                  ],
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
                  height: MediaQuery.of(context).size.height/2,
                  width:  MediaQuery.of(context).size.width/2-4,
                  child: Image.network(post.images[0], fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/4,
                      width:  MediaQuery.of(context).size.width/2-4,
                      child: Image.network(post.images[1], fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/4,
                    width:  MediaQuery.of(context).size.width/2-4,
                    child: Image.network(post.images[2], fit: BoxFit.cover),
                  ),
                ],
              )
            ],
          )
      );
    }
  }
}

import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/widgets/comment_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreateCommentWidget extends StatefulWidget {
  final HomeProvide provide;
  final Post post;

  CreateCommentWidget({this.post, this.provide});

  @override
  State<StatefulWidget> createState() {
    return _CreateCommentState(this.post, this.provide);
  }
}

class _CreateCommentState extends State<CreateCommentWidget> {
  String content = "";
  final HomeProvide provide;
  final Post post;

  _CreateCommentState(this.post, this.provide);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.97,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: 15.0, color: Colors.blue),
                    Text(' ${post.likes.length}'),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 30.0),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: post.comments.length,
              itemBuilder: (context, index) {
                return CommentWidget(
                  comment: post.comments[index], provide: provide,
                );
              }),
          Container(
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
                      onChanged: (text) {
                        setState(() {
                          content = text;
                        });
                      },
                      // decoration: InputDecoration(
                      //     border: InputBorder.none, hintText: 'Viết bình luận'),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Viết bình luận',
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
                      provide.addComment(post, content);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      size: 25.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

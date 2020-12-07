import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
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

  List<String> comments = [];

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
          SizedBox(height: 20.0),
          TextField(
            maxLines: null,
            minLines: 4,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18, color: Colors.black),
            onChanged: (text) {
              setState(() {
                content = text;
              });
            },
          ),
          SizedBox(height: 10.0),
          Divider(height: 30.0),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 17.0,
                  backgroundImage: NetworkImage(provide.userEntity.avatar),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: MediaQuery.of(context).size.width/1.5,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                          color: Colors.grey[400]
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: GestureDetector(
                      onTap: (){
                      },
                      child:Text('Viết bình luận')
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

import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/models/list_friend_model.dart';
import 'package:facebook_app/view/chat/people/widgets/personSearch.dart';
import 'package:facebook_app/widgets/messenger_app_bar/messenger_app_bar.dart';
int a = 0;
List<UserEntity> _list = List();
List<UserEntity> list2 = List();
class searchFriend extends StatefulWidget {
  final HomeProvide provide;

  searchFriend(this.provide);

  _searchFriendState createState() => _searchFriendState(provide);
}

class _searchFriendState extends State<searchFriend> {
  String content = "";
  ScrollController _controller;
  bool _isScroll = false;
  HomeProvide provide;
  Widget appBarTitle = new Text("Tìm kiếm", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  _searchFriendState(this.provide){
  }

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
    provide=widget.provide;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    // for(int i =0; i<provide.users.length;i++){
    //   if(provide.users[i]!=provide.userEntity){
    //     _list.add(provide.users[i]);
    //   }
    // }
    _list= provide.users;
    list2= provide.users;
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5,left: 16.0),
              child : Text(
                "Gợi ý",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                controller: _controller,
                itemCount:  list2.length,
                itemBuilder: (context, index) {
                  return personSearch(
                    list2[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  //  int _buildSearchScreen(){
  //   if (content.isEmpty||content==null) {
  //     list2=provide.users;
  //     for(int i=0;i<provide.users.length;i++){
  //       print("abc+${provide.users[i].lastName}");
  //     }
  //   }
  //   else {
  //     list2=List();
  //     for (int i = 0; i < provide.users.length; i++) {
  //       String  name = provide.users[i].firstName+" "+provide.users[i].lastName;
  //       if (name.toLowerCase().contains(content)) {
  //         list2.add(provide.users[i]);
  //       }
  //     }
  //   }
  //   return list2.length;
  // }
  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  onChanged: (text) {
                    setState(() {
                      content = _searchQuery.text;
                      if (content.isEmpty||content==null) {
                        list2=provide.users;
                      }
                      else {
                        list2=List();
                        for (int i = 0; i < provide.users.length; i++) {
                          String  name = provide.users[i].firstName+" "+provide.users[i].lastName;
                          if (name.toLowerCase().contains(content)) {
                            list2.add(provide.users[i]);
                          }
                        }
                      }
                          for(int i=0;i<list2.length;i++){
                            print("abc+${list2[i].lastName}");
                          }
                    });
                  },
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Tìm kiếm..",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Tìm kiếm", style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}




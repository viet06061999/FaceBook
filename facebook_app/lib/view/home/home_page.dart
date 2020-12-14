import 'package:facebook_app/base/base.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:facebook_app/view/tabs/home_tab.dart';
import 'package:facebook_app/view/tabs/friends_tab.dart';
import 'package:facebook_app/view/tabs/watch_tab.dart';
import 'package:facebook_app/view/tabs/profile_tab.dart';
import 'package:facebook_app/view/tabs/notifications_tab.dart';
import 'package:facebook_app/view/tabs/menu_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/chat.dart';

class HomePage extends PageProvideNode<HomeProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return HomePageTmp(mProvider);
  }
}

class HomePageTmp extends StatefulWidget {
  final HomeProvide provide;

  const HomePageTmp(this.provide);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTmp>
    with SingleTickerProviderStateMixin {
  HomeProvide _provide;
  TabController _tabController;
  var _controller = ScrollController();

  @override
  initState() {
    super.initState();
    _provide = widget.provide;
    _provide.init();
    _tabController = TabController(vsync: this, length: 6);
    // set up listener here
    _controller.addListener(() {
      if (_controller.position.pixels != 0) {
        _provide.isTop = false;
      }
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // you are at top position
          _provide.isTop = true;
        } else {
          // you are at bottom position
          print('bottom');
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('facebook',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(FontAwesomeIcons.facebookMessenger),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => App(_provide)),
                    );
                  },
                ), // xu ly tai day
              ]),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: TabBar(
            indicatorColor: Colors.blueAccent,
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blueAccent,
            tabs: [
              Tab(icon: Icon(Icons.home, size: 30.0)),
              Tab(icon: Icon(Icons.people, size: 30.0)),
              Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
              Tab(icon: Icon(Icons.account_circle, size: 30.0)),
              Tab(icon: Icon(Icons.notifications, size: 30.0)),
              Tab(icon: Icon(Icons.menu, size: 30.0))
            ],
          ),
        ),
        body: Consumer<HomeProvide>(builder: (context, value, child) {
          return TabBarView(controller: _tabController, children: [
            HomeTab(value, _controller),
            FriendsTab(),
            WatchTab(),
            ProfileTab(),
            NotificationsTab(value),
            MenuTab(value)
          ]);
        }));
  }
}

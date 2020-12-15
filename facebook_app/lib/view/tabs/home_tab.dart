import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:facebook_app/widgets/write_something_widget.dart';
import 'package:facebook_app/widgets/separator_widget.dart';
import 'package:facebook_app/widgets/post_widget.dart';
import 'package:facebook_app/widgets/stories_widget.dart';
import 'package:facebook_app/widgets/online_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final HomeProvide provide;

  const HomeTab(this.provide);

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        WriteSomethingWidget(provide: provide,),
        SeparatorWidget(),
        OnlineWidget(),
        SeparatorWidget(),
        StoriesWidget(),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provide.listPost.length,
            itemBuilder: (context, index) {
              return PostWidget(
                post: provide.listPost[index],
                provide: provide,
              );
            }),
      ],
    );
  }
}


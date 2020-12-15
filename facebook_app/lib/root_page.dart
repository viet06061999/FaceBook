import 'package:facebook_app/data/base_type/message_type.dart';
import 'package:facebook_app/data/model/messages.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/repository/chat_repository.dart';
import 'package:facebook_app/data/repository/friend_repository.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/source/local/user_local_data.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/data/source/remote/fire_base_user_storage.dart';
import 'package:facebook_app/view/home/home_page.dart';
import 'package:facebook_app/view/login/login_page.dart';
import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'data/repository/user_repository_impl.dart';
import 'package:facebook_app/ultils/string_ext.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

enum AuthStatus { notSignedIn, signIn, none }

class _RootPage extends State<RootPage> {
  AuthStatus status = AuthStatus.none;

  @override
  void initState() {
    super.initState();
    var userRepo = inject<UserRepository>();
    // var chatRepo = inject<ChatRepository>();
      });
    });
    // var from = UserEntity.origin();
    // var to = UserEntity.origin();
    // from.id = "y82MY9MUn2YzMBaE07OdLcbs5tf1";
    // to.id = "007uxyqTGXdvziH1zAcO7tBGuFZ2";
    // var message = Message(from, to, "Người yêu ơi có biết anh nhớ em nhiều lắm, những năm tháng trôi qua aa", "2020-12-12", MessageType.text);
    // chatRepo.sendMessage(message, from.id, to.id);
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AuthStatus.notSignedIn:
        return new LoginPage();
      case AuthStatus.signIn:
        return new HomePage();
      case AuthStatus.none:
        return new Container();
      default:
        return new Container();
    }
  }
}

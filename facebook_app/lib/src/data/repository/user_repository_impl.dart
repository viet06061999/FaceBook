import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  @override
  bool isUser(User user) {
   return true;
  }

}

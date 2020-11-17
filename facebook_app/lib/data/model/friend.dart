import 'package:facebook_app/data/base_type/friend_status.dart';
import 'package:facebook_app/data/model/user.dart';

class Friend {
  String idOwner = '-1';
  String created = '';
  String modified = '';
  UserEntity myFriend = UserEntity.origin();
  FriendStatus status = FriendStatus.none;

  Friend.origin();

  Friend(this.idOwner, this.myFriend, this.status);

  Friend.fromJson(Map map) {
    this.idOwner = map['id'];
    this.myFriend = UserEntity.fromJson(map['my_friend']);
    this.status = FriendStatus.values[int.parse(map['status'].toString())];
    this.created = map['created'];
    this.modified = map['modified'];
  }

  Map friendToMap() => new Map<String, dynamic>.from({
        "id": this.idOwner,
        "my_friend": this.myFriend,
        "status": this.status.index,
        "created": this.created,
        "modified": this.modified,
      });

  static List<Map> friendToListMap(List<Friend> friends) {
    List<Map> friendMap = [];
    friends.forEach((Friend friend) {
      Map step = friend.friendToMap();
      friendMap.add(step);
    });
    return friendMap;
  }

  static List<Friend> fromListMap(List<Map> maps) {
    List<Friend> friends = [];
    maps.forEach((element) {
      friends.add(Friend.fromJson(element));
    });
    return friends;
  }
}

import 'package:facebook_app/data/model/user.dart';

class Comment {
  UserEntity user = UserEntity.origin();
  String comment = "";

  Comment.origin();

  Comment( this.user, this.comment);

  Map toMap() => new Map<String, dynamic>.from({
    "user": this.user.userToMap(),
    "comment": this.comment,
  });

  static List<Map> toListMap(List<Comment> comments) {
    List<Map> maps = [];
    comments.forEach((Comment comment) {
      Map step = comment.toMap();
      maps.add(step);
    });
    return maps;
  }
}

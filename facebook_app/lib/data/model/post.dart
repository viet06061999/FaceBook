import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';

class Post {
  String id = '-1';
  String described = '';
  String created = '';
  String modified = '';
  List<UserEntity> likes = [];
  List<Comment> comments = [];
  List<String> images = [];
  List<Video> videos = [];
  UserEntity owner = UserEntity.origin();

  Post.origin();

  Post(this.id, this.described, this.created, this.modified, this.likes,
      this.comments, this.images, this.videos, this.owner);

  Map postToMap() => new Map<String, dynamic>.from({
        "id": this.id,
        "described": this.described,
        "created": this.created,
        "modified": this.modified,
        "owner": this.owner.userToMap(),
        "comments": Comment.toListMap(this.comments),
        "likes": UserEntity.userToListMap(this.likes),
        "images": this.images,
        "videos": Video.toListMap(this.videos),
      });

  static List<Map> toListMap(List<Post> posts) {
    List<Map> maps = [];
    posts.forEach((Post post) {
      Map step = post.postToMap();
      maps.add(step);
    });
    return maps;
  }
}

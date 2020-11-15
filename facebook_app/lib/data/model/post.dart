import 'package:facebook_app/data/model/comment.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:facebook_app/data/model/video.dart';

class Post {
  String postId = '-1';
  String described = '';
  String created = '';
  String modified = '';
  List<UserEntity> likes = [];
  List<Comment> comments = [];
  List<String> images = [];
  List<Video> videos = [];
  UserEntity owner = UserEntity.origin();

  Post.origin();

  Post(this.postId, this.described, this.created, this.modified, this.likes,
      this.comments, this.images, this.videos, this.owner);

  Post.fromMap(Map map) {
    this.postId = map['post_id'];
    this.described = map['described'];
    this.created = map['created'];
    this.modified = map['modified'];
    this.likes =  (map['likes'] as List).map((e) => UserEntity.fromJson(e)).toList();
    this.comments =(map['comments'] as List).map((e) => Comment.fromJson(e)).toList();
    this.images = (map['images'] as List).map((e) => e.toString()).toList() ;
    this.videos = (map['videos'] as List).map((e) => Video.fromJson(e)).toList();
    this.owner = UserEntity.fromJson(map['owner']);
  }

  Map postToMap() => new Map<String, dynamic>.from({
        "post_id": this.postId,
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

  static List<Post> fromListMap(List<Map> maps) {
    List<Post> posts = [];
    maps.forEach((element) {
      posts.add(Post.fromMap(element));
    });
    return posts;
  }
}

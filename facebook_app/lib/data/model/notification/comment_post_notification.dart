import 'package:facebook_app/data/base_type/notification_type.dart';
import 'package:facebook_app/data/model/notification/notification_post.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:facebook_app/data/model/user.dart';

class NotificationCommentPost extends NotificationPost {

  NotificationCommentPost(
      Post post,
      UserEntity userSecond,
      UserEntity userFirst,
      String updateTime,
      NotificationType type,
      double others,
      List<String> receivers)
      : super(post, userSecond, userFirst, updateTime, type, others,
            receivers);

  @override
  String getContent({String userId}) {
    if (others > 0) {
      if (userId == post.owner.id)
        return "và $others đã bình luận bài viết của bạn";
      else
        return " đã bình luận bài viết của bạn";
    } else {
      if (userId == post.owner.id)
        return "và $others đã bình luận bài viết bạn đang theo dõi";
      else
        return " đã bình luận bài viết bạn đang theo dõi";
    }
  }
}

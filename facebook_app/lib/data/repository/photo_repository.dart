import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

abstract class PhotoRepository {
  Future<void> uploadPhoto(String filePath, Function(String) onSuccess, Function onError);
}

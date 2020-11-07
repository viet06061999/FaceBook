import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/post.dart';
import 'package:rxdart/rxdart.dart';

class FirPost {
  final FirebaseFirestore _firestore;

  FirPost(this._firestore);

 Observable<DocumentReference> createPost(Post post){
   return Observable.fromFuture(_firestore.collection("posts").add(post.postToMap()));
  }
}

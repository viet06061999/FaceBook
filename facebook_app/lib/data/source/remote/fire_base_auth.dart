import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth;

  FirAuth(this._firebaseAuth);

  Observable<UserCredential> signIn(String email, String password) {
    return Observable.fromFuture(_firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password));
  }

  Future<void> signOut(Function signOut) {
    _firebaseAuth.signOut().then((value) {
      signOut();
    });
  }

  Future<void> signUp(
      String firstName,
      String lastName,
      String avatar,
      String birthday,
      String email,
      String phone,
      String password,
      String genre,
      Function onSuccess,
      Function(String code) onError) {
    print('$email $password');
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _createUser(
          UserEntity(value.user.uid, firstName, lastName, '', birthday, email,
              phone, password, genre),
          value.user.uid,
          onSuccess);
    }).catchError((err) {
      print(err);
      onError(err.code);
    });
  }

  Future<UserEntity> curentUser() async {
    User user = await _firebaseAuth.currentUser;
    UserEntity userEntity;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    if (user != null) {
      await users.doc(user.uid).get().then((value) {
        userEntity = UserEntity.fromJson(value.data());
        print(userEntity);
      }).catchError((onError){
        print(onError);
      });
    }
    return userEntity;
  }

  _createUser(UserEntity user, String document, Function onSuccess) {
    var db = FirebaseFirestore.instance;
    db
        .collection("users")
        .doc(document)
        .set(user.userToMap())
        .catchError((onError) {
      print(onError);
    }).then((value) {
      onSuccess();
    });
  }
}

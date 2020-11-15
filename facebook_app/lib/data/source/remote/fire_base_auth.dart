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
          UserEntity(value.user.uid, firstName, lastName, '', birthday, email, phone,
              password, genre),
          onSuccess);
    }).catchError((err) {
      print(err);
       onError(err.code);
    });
  }

  Future<User> curentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user;
  }

  _createUser(UserEntity user, Function onSuccess) {
    var db = FirebaseFirestore.instance;
    db
        .collection("users")
        .add(user.userToMap())
        .catchError((onError) {
      print(onError);
    })
        .then((value) {
      onSuccess();
    });
  }
}

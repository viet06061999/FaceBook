import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth ;

  FirAuth(this._firebaseAuth);

  Observable<AuthResult> signIn(String email, String password) {
    // _firebaseAuth
    //     .signInWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //   onSuccess();
    // }).catchError((err) {
    //   onError(err.code);
    // });
    return Observable.fromFuture(_firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
  }

  Future<void> signOut(Function signOut) {
    _firebaseAuth.signOut().then((value) {
      signOut();
    });
  }

  Future<void> signUp(
      String firstName,
      String lastName,
      String birthday,
      String email,
      String phone,
      String password,
      Function onSuccess,
      Function(String code) onError) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      _createUser(
          User(value.user.uid, firstName, lastName, birthday, email, phone,
              password),
          onSuccess);
    }).catchError((err) {
      print('$err ${err.code}');
      onError(err.code);
    });
  }

  Future<String> curentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.email;
  }

  _createUser(User user, Function onSuccess) {
    var userInfo = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone": user.phone,
      "birthday": user.birthday
    };
    var db = Firestore.instance;
    db.collection("users").add(userInfo).catchError((onError) {}).then((value) {
      onSuccess();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Future<void> singIn(String email, String password, Function onSuccess){
  //   return _firebaseAuth.sendSignInWithEmailLink(email: email, url: null, handleCodeInApp: null, iOSBundleID: null, androidPackageName: null, androidInstallIfNotAvailable: null, androidMinimumVersion: null)
  // }
  //
  Future<void> signUp(String firstName, String lastName, String birthday,
      String email, String phone, String password, Function onSuccess)  {
    return  _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _createUser(
          User(value.user.uid, firstName, lastName, birthday, email, phone,
              password),
          onSuccess);
    }).catchError((err){print(err);
    });
  }

  _createUser(User user, Function onSuccess)  {
    var userInfo = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone": user.phone,
      "birthday": user.birthday
    };
    var db = Firestore.instance;
    db.collection("users")
    .add(userInfo)
    .catchError((onError){})
    .then((value) {
      onSuccess();
    });
  }
  void _onSignUpErr(String code, Function(String) onRegisterError){
    switch (code){
      case "ERROR_INVALID_EMAIL":
    }
  }
}

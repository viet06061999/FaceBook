import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartin/dartin.dart';
import 'package:facebook_app/data/repository/photo_repository.dart';
import 'package:facebook_app/data/repository/photo_repository_impl.dart';
import 'package:facebook_app/data/repository/post_repository.dart';
import 'package:facebook_app/data/repository/post_repository_impl.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/repository/user_repository_impl.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/data/source/remote/fire_base_post.dart';
import 'package:facebook_app/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:facebook_app/viewmodel/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

const testScope = DartInScope('test');

//viewmodel

final viewModelModule = Module([
  factory<LoginProvide>(({params}) => LoginProvide(get())),
  factory<HomeProvide>(({params}) => HomeProvide(get(), get())),
])
  ..withScope(testScope, [
    factory<LoginProvide>(({params}) => LoginProvide(get())),
    factory<HomeProvide>(({params}) => HomeProvide(get(), get())),
  ]);

final repoModule = Module([
  factory<UserRepository>(({params}) => UserRepositoryImpl(get(), get())),
  factory<PostRepository>(({params}) => PostRepositoryImpl(get(), get())),
  factory<PhotoRepository>(({params}) => PhotoRepositoryImpl(get())),
]);

//remote
final remoteModule = Module([
  factory<FirAuth>(({params}) => FirAuth(get())),
  factory<FirPost>(({params}) => FirPost(get())),
  factory<FirUploadPhoto>(({params}) => FirUploadPhoto(get())),
]);

final firebase = Module([
  factory<FirebaseAuth>(({params}) => FirebaseAuth.instance),
  factory<FirebaseFirestore>(({params}) => FirebaseFirestore.instance),
  factory<FirebaseStorage>(({params}) => FirebaseStorage.instance),
]);

final localModule = Module([
  single<SpUtil>(({params}) => spUtil),
]);

final appModule = [
  viewModelModule,
  repoModule,
  firebase,
  remoteModule,
  localModule
];

SpUtil spUtil;

init() async {
  spUtil = await SpUtil.getInstance();
  // DartIn start
  startDartIn(appModule);
}

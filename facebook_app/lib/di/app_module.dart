import 'package:dartin/dartin.dart';
import 'package:facebook_app/data/repository/user_repository.dart';
import 'package:facebook_app/data/repository/user_repository_impl.dart';
import 'package:facebook_app/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/helper/share_prefs.dart';
import 'package:facebook_app/viewmodel/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

const testScope = DartInScope('test');

//viewmodel

final viewModelModule = Module([
  factory<LoginProvide>(({params}) => LoginProvide(get())),
])
  ..withScope(testScope, [
    factory<LoginProvide>(({params}) => LoginProvide(get())),
  ]);

final repoModule = Module(
    [factory<UserRepository>(({params}) => UserRepositoryImpl(get(), get()))]);

//remote
final remoteModule = Module([
  factory<FirAuth>(({params}) => FirAuth(get())),
]);

final firebase = Module([
  factory<FirebaseAuth>(({params}) => FirebaseAuth.instance),
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

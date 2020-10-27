import 'package:provider/provider.dart';

import 'di/app_module.dart';
import 'file:///C:/Users/vietl/Desktop/FaceBook/facebook_app/lib/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

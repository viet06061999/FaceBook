import 'package:connectivity/connectivity.dart';

Future<bool> isAvailableInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
   return true;
  } else {
    return false;
  }
}

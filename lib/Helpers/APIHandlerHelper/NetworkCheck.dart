import 'dart:async';

import '../Utitilites/Utilities.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkCheck {
  /* Create a checkInternetConnectivity method to check the device's internet connection */
  static Future<bool> checkInternetConnectivity() async {
    try {
      // Invoke InternetConnectionChecker().hasConnection to observer the connection and store it in result.
      bool result = await InternetConnectionChecker().hasConnection;

      // Check, if result is true return true
      // Else, return false.
      return (result == true) ? true : false;
    } catch (e) {
      e.writeExceptionData();
      return false;
    }
  }

  static Stream<InternetConnectionStatus> checkInternetConnectivityStream() {
    try {
      return InternetConnectionChecker().onStatusChange;
    } catch (e) {
      e.writeExceptionData();
      rethrow;
    }
  }
}

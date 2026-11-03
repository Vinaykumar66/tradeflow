import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static Future<void> ensureInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // Check if the device has any connection type (mobile, wifi, ethernet, etc.)
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception(
          'No internet connection available. Please check your network settings.');
    }
  }
}

import 'dart:io';

class Utils {
  Utils._privateConstructor();
static final Utils _instance = Utils._privateConstructor();
static Utils get instance => _instance;
  static Future<bool> isConnected() async {
    try {
      List<InternetAddress> result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 5));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }


}

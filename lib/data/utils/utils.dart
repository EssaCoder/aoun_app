import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:aoun/main.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

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
  static Future<String?> saveWidget(GlobalKey globalKey)async{

    RenderRepaintBoundary? boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary!.toImage();
    final  byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return (await _writeFile(base64Encode(pngBytes!)))?.path;

  }
  static Future<Directory?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await Directory('/storage/emulated/0/Download/Aoun').create(recursive: true);
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (__, _) {}
    return directory;
  }
  static Future<File?> _writeFile(String base64) async {
    var directory = await _getDownloadPath();
    if(directory==null)return null;
    final file = File(
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');

    return file.writeAsBytes(base64Decode(base64));
  }
  static logOut() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
      SharedValues.loginRoute,
      ModalRoute.withName(SharedValues.loginRoute));
  static  bool validateEmail(String value){
    String  pattern = r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

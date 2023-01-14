import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
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
}

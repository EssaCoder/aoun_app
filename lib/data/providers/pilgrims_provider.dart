import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/repositories/pilgrims_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '/data/network/data_response.dart';
import '/data/models/user.dart';
import '/data/di/service_locator.dart';

class PilgrimsProvider extends ChangeNotifier {
  final _pilgrimsRepository = getIt.get<PilgrimsRepository>();
  PilgrimsProvider(this._user);
  final User? _user;
  List<Pilgrim> pilgrims=[];
  Future<Result> setPilgrim(Pilgrim pilgrim) async {
    return await _pilgrimsRepository.setPilgrim(pilgrim);
  }

  Future<Result> getPilgrims() async {
    Result result = await _pilgrimsRepository.getPilgrims();
    if(result is Success){
      pilgrims=result.value;
    }
    return result;
  }
  Future<Pilgrim?> getPilgrim(int id) async {
    Result result = await _pilgrimsRepository.getPilgrim(id);
    if(result is Success){
      return result.value;
    }
    return null;
  }
  Future<Pilgrim?> scanPilgrim() async {
    String barcodeScanRes =
    await _scanBarcode();
    if(int.tryParse(barcodeScanRes)!=null){
      Pilgrim? pilgrim =await getPilgrim(int.parse(barcodeScanRes));
      notifyListeners();
      return pilgrim;
    }
    return null;
  }
  Future<String> _scanBarcode() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#000000", "0", true, ScanMode.BARCODE);
  }
}

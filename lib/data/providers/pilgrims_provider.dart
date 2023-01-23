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
  List<Pilgrim> _pilgrims = [];
  List<Pilgrim> pilgrims = [];
  Future<Result> setPilgrim(Pilgrim pilgrim) async {
    return await _pilgrimsRepository.setPilgrim(pilgrim);
  }

  void searchPilgrims({String? search, bool? isMyAccount}) {
    if (isMyAccount ?? false) {
      pilgrims =
          _pilgrims.where((element) => element.userID == _user!.id).toList();
    } else {
      pilgrims = _pilgrims
          .where((element) =>
              element.name
                  .toUpperCase()
                  .contains(search?.toUpperCase() ?? "") ||
              element.id.toString().contains(search ?? ""))
          .toList();
    }
    notifyListeners();
  }

  Future<Result> getPilgrims() async {
    Result result = await _pilgrimsRepository.getPilgrims();
    if (result is Success) {
      _pilgrims = result.value;
      pilgrims = _pilgrims;
      notifyListeners();
    }
    return result;
  }

  Future<Pilgrim?> getPilgrim(int id) async {
    Result result = await _pilgrimsRepository.getPilgrim(id);
    if (result is Success) {
      return result.value;
    }
    return null;
  }

  Future<Pilgrim?> scanPilgrim() async {
    String barcodeScanRes = await _scanBarcode();
    if (int.tryParse(barcodeScanRes) != null) {
      Pilgrim? pilgrim = await getPilgrim(int.parse(barcodeScanRes));
      notifyListeners();
      return pilgrim;
    }
    return null;
  }

  Future<String> _scanBarcode() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#000000", "0", true, ScanMode.BARCODE);
  }

  Future<Result> updatePilgrim(Pilgrim pilgrim) async {
    try {
      Result result= await _pilgrimsRepository.updatePilgrim(pilgrim);
      if(result is Success){
        await getPilgrims();
      }
      return result;
    } catch (e) {
      return Error(e);
    }
  }
}

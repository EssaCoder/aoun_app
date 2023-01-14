import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/repositories/pilgrims_repository.dart';
import 'package:flutter/material.dart';
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

}

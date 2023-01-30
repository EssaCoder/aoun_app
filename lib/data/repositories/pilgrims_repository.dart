import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/network/api/pilgrims_api.dart';
import 'package:flutter/foundation.dart';
import '/data/network/data_response.dart';

class PilgrimsRepository {
  final PilgrimsApi _pilgrimsApi;
  PilgrimsRepository(this._pilgrimsApi);

  Future<Result> setPilgrim(Pilgrim pilgrim) async {
    try {
      debugPrint(
          "==========AuthRepository->signUp->user:${pilgrim.toJson()} ==========");
      await _pilgrimsApi.setPilgrim(pilgrim.toJson());
      return Success();
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> getPilgrims() async {
    try {
      final response = await _pilgrimsApi.getPilgrims();
      final pilgrims = response.map((e) => Pilgrim.fromJson(e.data())).toList();
      return Success(pilgrims);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> getPilgrim(int id) async {
    try {
      final response = await _pilgrimsApi.getPilgrim(id);
      final pilgrim = Pilgrim.fromJson(response.data());
      return Success(pilgrim);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> updatePilgrim(Pilgrim pilgrim) async {
    try {
      return Success(
          await _pilgrimsApi.updatePilgrim(pilgrim.id, pilgrim.toJson()));
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> getAds() async {
    try {
      final response = await _pilgrimsApi.getAds();
      final pilgrims = response.map((e) => Pilgrim.fromJson(e.data())).toList();
      return Success(pilgrims);
    } catch (e) {
      return Error(e);
    }
  }
}

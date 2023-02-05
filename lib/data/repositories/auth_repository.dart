import 'dart:convert';

import 'package:aoun/data/network/http_exception.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:flutter/foundation.dart';
import '/data/local/sharedpref_helper/preference_variable.dart';
import '/data/local/sharedpref_helper/preferences.dart';
import '/data/models/user.dart';
import '/data/network/data_response.dart';
import '/data/network/api/auth_api.dart';

class AuthRepository {
  final AuthApi _authApi;
  final _preferences = Preferences.instance;
  AuthRepository(this._authApi);

  Future<Result> signUp(User user) async {
    try {
      debugPrint(
          "==========AuthRepository->signUp->user:${user.toJson()} ==========");
      var id = await _authApi.setUser(user.toJson());
      if (id == null) {
        return Error(ExistUserException());
      }
      return Success(user);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> signIn(String phone, String password) async {
    try {
      final response = await _authApi.getUser(phone, password);
      final data = {
        ...response.data(),
      };
      final user = User.fromJson(data);
      if (user.userRole == UserRole.disable) {
        return Error(UnauthorisedException(
            "You don't have permission to access on this user"));
      }
      await _preferences.delete(PreferenceVariable.user);
      await _preferences.insert(
          PreferenceVariable.user, jsonEncode(user.toJson()));
      return Success(user);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> signOut() async {
    try {
      bool status = await _preferences.delete(PreferenceVariable.user);
      return Success(status);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> sendCode(String phone, bool sendIfExist) async {
    try {
      final isExist=(await _authApi.checkUser(phone))?.data() != null;
      if(sendIfExist&&isExist){
        bool status = await _authApi.sendCode(phone);
        return Success(status);
      }else if(!sendIfExist&&!isExist){
        bool status = await _authApi.sendCode(phone);
        return Success(status);
      }else {
        return Error(ExistUserException());
      }
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> verifyCode(String phone, String smsCode) async {
    try {
      bool status = await _authApi.verifyCode(phone, smsCode);
      debugPrint("============ $status ============");
      return Success(status);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> showUsers(int id) async {
    try {
      debugPrint("==========AuthRepository->signUp==========");
      final response = await _authApi.showUsers(id);
      final users = response.map((e) => User.fromJson(e.data())).toList();

      return Success(users);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> updateUser(User user) async {
    try {
      return Success(
          await _authApi.updateUser(user.id.toString(), user.toJson()));
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> getUserData(String phone, String password) async {
    try {
      return await signIn(phone, password);
    } catch (e) {
      return Error(e);
    }
  }

  Future<bool> changePassword(String phone, String password) async {
    try {
      return await _authApi.changePassword(phone, {"password": password});
    } catch (_) {
      return false;
    }
  }
}

import 'dart:convert';

import 'package:aoun/data/network/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
      String? id = await _authApi.setUser(user.toJson());
      if (id == null) {
        return Error(ExistUserException());
      }
      await _preferences.delete(PreferenceVariable.user);
      await _preferences.insert(
          PreferenceVariable.user, jsonEncode(user.toJson()));
      return Success(user);
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> signIn(int studentNumber, String password) async {
    try {
      debugPrint(
          "==========AuthRepository->signIn->studentNumber/password:$studentNumber / $password ==========");
      final response = await _authApi.getUser(studentNumber, password);
      final data = {
        ...response.data(),
      };
      final user = User.fromJson(data);
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

  Future<Result> sendCode(String phone,
      {required auth.PhoneVerificationCompleted verificationCompleted,
      required auth.PhoneVerificationFailed verificationFailed,
      required auth.PhoneCodeSent codeSent,
      required auth.PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout}) async {
    try {
      await _authApi.sendCode(phone,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      return Success();
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> verifyCode(String verificationId, String smsCode) async {
    try {
      bool status = await _authApi.verifyCode(verificationId, smsCode);
      debugPrint("============ $status ============");
      return Success();
    } catch (e) {
      return Error(e);
    }
  }
}

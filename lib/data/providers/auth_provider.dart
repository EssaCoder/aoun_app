import 'package:flutter/material.dart';
import '/data/network/data_response.dart';
import '/data/models/user.dart';
import '/data/di/service_locator.dart';
import '/data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepository = getIt.get<AuthRepository>();
  User? _user;
  User? get user => _user;
  String? verificationId;
  Future<Result> signUp(User user) async {
    Result result = await _authRepository.signUp(user);
    if (result is Success) {
      _user = result.value;
    }
    return result;
  }

  Future<Result> signIn(int studentNumber, String password) async {
    Result result = await _authRepository.signIn(studentNumber, password);
    if (result is Success) {
      _user = result.value;
    }
    return result;
  }

  void setUser(User? user) {
    _user = user;
  }

  Future<void> signOut() async {
    Result result = await _authRepository.signOut();
    if (result is Success) {
      _user = null;
    }
  }

  Future<Result> sendCode(User? user) async {
    try {
      setUser(user);
      if(_user?.phone!=null) {
        Result result=await _authRepository.sendCode(_user!.phone);
        return result;
      }
      return Error();
    } catch (e) {
      return Error(e);
    }
  }
  Future<Result> verifyCode(String smsCode) async {
    try {
      debugPrint("===============AuthProvider->verifyCode->smsCode: ${smsCode} ==============");
      setUser(user);
      if(_user?.phone!=null) {
        Result result=await _authRepository.verifyCode(_user!.phone,smsCode);
        return result;
      }
      return Error();
    } catch (e) {
      return Error(e);
    }
  }
}

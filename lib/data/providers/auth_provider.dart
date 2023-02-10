import 'package:aoun/data/network/http_exception.dart';
import 'package:aoun/data/utils/utils.dart';
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

  Future<Result> signIn(String phone, String password) async {
    Result result = await _authRepository.signIn(phone, password);
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

  Future<Result> sendCode(User user,bool sendIfExist) async {
    try {
      setUser(user);
      Result result = await _authRepository.sendCode(user.phone,sendIfExist);
      return result;
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> verifyCode(String smsCode,bool isSignUp) async {
    try {
      debugPrint(
          "===============AuthProvider->verifyCode->smsCode: ${smsCode} ==============");
      Result result = await _authRepository.verifyCode(_user!.phone, smsCode);
      debugPrint(
          "===============AuthProvider->verifyCode->result: ${result} ==============");
      if (result is Success&&result.value==true) {
        return isSignUp ? await _authRepository.signUp(_user!) : result;
      }
      return Error();
    } catch (e) {
      return Error(e);
    }
  }

  List<User> users = [];

  Future<void> showUsers() async {
    debugPrint("==========AuthRepository->signUp==========");
    Result result = await _authRepository.showUsers(_user!.id!);
    if (result is Success) {
      users = result.value;
      users.removeWhere((element) => element.id == _user!.id);
      notifyListeners();
    }
  }

  Future<Result> updateUser(User user) async {
    debugPrint("==========AuthRepository->signUp==========");
    Result result = await _authRepository.updateUser(user);
    return result;
  }
  Future<void> getUserData() async {
    Result result = await _authRepository.getUserData(
        _user?.phone ?? "", _user?.password ?? "");
    if (result is Success) {
      _user = result.value;
    }else if(result is Error&&result.exception is UnauthorisedException){
      Utils.logOut();
    }
    notifyListeners();
  }
  Future<bool> changePassword() async {
    return await _authRepository.changePassword(
        _user!.phone,_user!.password);
  }
}

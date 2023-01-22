import 'package:aoun/data/utils/enum.dart';
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

  Future<Result> signIn(int userID, String password) async {
    Result result = await _authRepository.signIn(userID, password);
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

  Future<Result> sendCode(User user) async {
    try {
      setUser(user);
      Result result = await _authRepository.sendCode(user.phone);
      return result;
    } catch (e) {
      return Error(e);
    }
  }

  Future<Result> verifyCode(String smsCode) async {
    try {
      debugPrint(
          "===============AuthProvider->verifyCode->smsCode: ${smsCode} ==============");
      Result result = await _authRepository.verifyCode(_user!.phone, smsCode);
      if (result is Success) {
        return await _authRepository.signUp(_user!);
      }
      return Error();
    } catch (e) {
      return Error(e);
    }
  }
  List<User> users = [];

  Future<void> showUsers() async {
    debugPrint("==========AuthRepository->signUp==========");
    Result result = await _authRepository.showUsers();
    if (result is Success) {
      users = result.value;
      notifyListeners();
    }
  }
  Future<void> changePermission(User user) async {
    debugPrint("==========AuthRepository->signUp==========");
    Result result = await _authRepository.updateUser(user);
    if (result is Success) {
      users = result.value;
      notifyListeners();
    }
  }
}

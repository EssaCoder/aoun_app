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

  Future<Result> sendCode(String phone) async {
    try {
      await _authRepository.sendCode(
        phone,
        verificationCompleted: (_) {
          debugPrint("=============verificationCompleted ===========");
        },
        verificationFailed: (_) {
          debugPrint("=============verificationFailed ===========");},
        codeSent: (verificationId, _) {
          debugPrint("=============codeSent ===========");
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (_) {
          debugPrint("=============codeAutoRetrievalTimeout ===========");},
      );
      return Success();
    } catch (e) {
      return Error(e);
    }
  }
}

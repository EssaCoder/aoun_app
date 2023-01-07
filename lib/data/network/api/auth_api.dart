import 'package:aoun/data/network/data_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '/data/utils/extension.dart';
import 'constants/endpoint.dart';

class AuthApi {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> setUser(Map<String, dynamic> body) async {
    try {
      if ((await checkUser(body["student-number"]))?.data() == null) {
        DocumentReference documentRef =
            await _fireStore.collection(Endpoints.users).add(body);
        return documentRef.id;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendCode(String phone,
      {required PhoneVerificationCompleted verificationCompleted,
      required PhoneVerificationFailed verificationFailed,
      required PhoneCodeSent codeSent,
      required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+967777339975",
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 120)
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyCode(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      debugPrint("============ $credential ============");
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUser(
      int studentNumber, String password) async {
    try {
      final response = await _fireStore
          .collection(Endpoints.users)
          .where("student-number", isEqualTo: studentNumber)
          .where("password", isEqualTo: password)
          .get();
      return response.docs.first;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> checkUser(int id) async {
    try {
      final response = await _fireStore
          .collection(Endpoints.users)
          .where("student-number", isEqualTo: id)
          .get();
      return response.docs.firstOrNull;
    } catch (e) {
      rethrow;
    }
  }
}

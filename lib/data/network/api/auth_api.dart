import 'package:aoun/data/network/data_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';
import '/data/utils/extension.dart';
import 'constants/endpoint.dart';

class AuthApi {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: 'AC21ec03a85b5e447bd560f19f932f0005',
      authToken: '46bd25b7b96677232bf4771fc0d3653b',
      serviceSid: 'VA7534bdacc6f2c1f33c93842b6dee6811');
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

  Future<bool> sendCode(String phone) async {
    try {
      debugPrint("=============AuthApi->sendCode =============");
      TwilioResponse twilioResponse =
          await _twilioPhoneVerify.sendSmsCode(phone);
      if (twilioResponse.successful ?? false) {
        debugPrint("=============AuthApi->sendCode->successful =============");
        return true;
      } else {
        debugPrint("=============AuthApi->sendCode->error =============");
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyCode(String phone, String smsCode) async {
    try {
      var twilioResponse =
          await _twilioPhoneVerify.verifySmsCode(phone: phone, code: smsCode);

      if ((twilioResponse.successful ?? false) &&
          twilioResponse.verification?.status == VerificationStatus.approved) {
        return true;
      }

      return false;
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

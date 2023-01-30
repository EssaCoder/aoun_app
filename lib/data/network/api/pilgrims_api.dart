import 'dart:io';

import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/data/utils/extension.dart';
import 'package:aoun/data/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'constants/endpoint.dart';

class PilgrimsApi {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref("pilgrims/images");

  Future<String?> setPilgrim(Map<String, dynamic> body) async {
    try {
      if (body["url"]!=null&&(await File(body["url"]).exists())) {
        final uploadTask = await storageRef.putFile(File(body["url"]));
        String url = await uploadTask.ref.getDownloadURL();
        body["url"] = url;
      }
      DocumentReference documentRef =
          await _fireStore.collection(Endpoints.pilgrims).add(body);
      return documentRef.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getPilgrims() async {
    try {
      final response = await _fireStore
          .collection(Endpoints.pilgrims)
          .where("deleteAt", isNull: true)
          .get();
      return response.docs;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getPilgrim(int id) async {
    try {
      final response = await _fireStore
          .collection(Endpoints.pilgrims)
          .where("id", isEqualTo: id)
          .get();
      return response.docs.first;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePilgrim(int id, Map<String, dynamic> body) async {
    try {
      if (body["url"]!=null&&(await File(body["url"]).exists())) {
        final uploadTask = await storageRef.putFile(File(body["url"]));
        String url = await uploadTask.ref.getDownloadURL();
        body["url"] = url;
      }
      final response = await _fireStore
          .collection(Endpoints.pilgrims)
          .where("id", isEqualTo: id)
          .get();
      await _fireStore
          .collection(Endpoints.pilgrims)
          .doc(response.docs.firstOrNull?.id)
          .update(body);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAds() async {
    try {
      final response = await _fireStore
          .collection(Endpoints.pilgrims)
          .where("deleteAt", isNull: true)
          .where("status", isEqualTo: PilgrimStatus.missing.name)
          .get();
      return response.docs;
    } catch (e) {
      rethrow;
    }
  }
}

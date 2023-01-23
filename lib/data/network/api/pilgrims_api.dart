import 'package:aoun/data/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants/endpoint.dart';

class PilgrimsApi {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String?> setPilgrim(Map<String, dynamic> body) async {
    try {
      DocumentReference documentRef =
      await _fireStore.collection(Endpoints.pilgrims).add(body);
        return documentRef.id;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPilgrims() async {
    try {
      final response=  await _fireStore
          .collection(Endpoints.pilgrims)
      .where("deleteAt",isNull:  true)
          .get();
      return response.docs;
    } catch (e) {
      rethrow;
    }
  }
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getPilgrim(int id) async {
    try {
      final response=  await _fireStore
          .collection(Endpoints.pilgrims)
      .where("id",isEqualTo: id)
          .get();
      return response.docs.first;
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> updatePilgrim(int id,Map<String, dynamic> body) async {
    try {
      final response=  await _fireStore
          .collection(Endpoints.pilgrims)
          .where("id", isEqualTo: id)
          .get();
      await _fireStore
          .collection(Endpoints.pilgrims).doc(response.docs.firstOrNull?.id).update(body);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

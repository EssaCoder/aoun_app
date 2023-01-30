import 'package:aoun/data/utils/enum.dart';

class Pilgrim {
  int id;
  String name;
  String address;
  String phone;
  String supervisorPhone;
  String healthStatus;
  String healthProblem;
  int userID;
  String? url;
  DateTime? deleteAt;
  PilgrimStatus status;

  Pilgrim(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      this.url,
      required this.supervisorPhone,
      required this.healthStatus,
      required this.healthProblem,
      required this.userID,
        required this.status,
      this.deleteAt});

  factory Pilgrim.fromJson(Map<String, dynamic> json) {
    return Pilgrim(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      supervisorPhone: json["supervisorPhone"],
      url: json["url"],
      status: (){
        if(json["status"]==PilgrimStatus.missing.name){
          return PilgrimStatus.missing;
        }
        return PilgrimStatus.none;
      }(),
      healthStatus: json["healthStatus"],
      healthProblem: json["healthProblem"],
      userID: json["userID"],
      deleteAt: DateTime.tryParse(json["deleteAt"]??""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "supervisorPhone": supervisorPhone,
      "url": url,
      "healthStatus": healthStatus,
      "healthProblem": healthProblem,
      "userID": userID,
      "status": status.name,
      "deleteAt": deleteAt?.toIso8601String(),
    };
  }
//

}

class Pilgrim {
  int id;
  String name;
  String address;
  String phone;
  String supervisorPhone;
  String healthStatus;
  String healthProblem;
  int userID;
  DateTime? deleteAt;

  Pilgrim(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.supervisorPhone,
      required this.healthStatus,
      required this.healthProblem,
      required this.userID,
      this.deleteAt});

  factory Pilgrim.fromJson(Map<String, dynamic> json) {
    return Pilgrim(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      supervisorPhone: json["supervisorPhone"],
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
      "healthStatus": healthStatus,
      "healthProblem": healthProblem,
      "userID": userID,
      "deleteAt": deleteAt?.toIso8601String(),
    };
  }
//

}

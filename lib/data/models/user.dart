import 'package:aoun/data/utils/enum.dart';

class User {
  int id;
  String name;
  String email;
  String phone;
  String identityNumber;
  UserType userType;
  String password;
  UserRole userRole;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.identityNumber,
      required this.userType,
      required this.userRole,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      userRole: () {
        if (json["roles"] == "superAdmin") {
          return UserRole.superAdmin;
        } else if (json["roles"] == "admin") {
          return UserRole.admin;
        } else if (json["roles"] == "employee") {
          return UserRole.employee;
        }

        return UserRole.disable;
      }(),
      email: json["email"],
      phone: json["phone"],
      identityNumber: json["identityNumber"],
      userType: json["userType"] == "user" ? UserType.user : UserType.employee,
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "identityNumber": identityNumber,
      "userType": userType.name,
      "password": password,
      "roles": userRole.name
    };
  }
}

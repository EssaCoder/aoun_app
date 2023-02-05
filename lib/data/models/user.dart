import 'package:aoun/data/utils/enum.dart';

class User {
  int? id;
  String? name;
  String? email;
  String phone;
  String? identityNumber;
  String password;
  UserRole? userRole;

  User(
      {this.id,
      this.name,
      this.email,
   required   this.phone,
      this.identityNumber,
      this.userRole,
        required   this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      userRole: () {
        if (json["roles"] ==UserRole.superAdmin.name) {
          return UserRole.superAdmin;
        } else if (json["roles"] == UserRole.employee.name) {
          return UserRole.employee;
        } else if (json["roles"] == UserRole.user.name) {
          return UserRole.user;
        }
        return UserRole.disable;
      }(),
      email: json["email"],
      phone: json["phone"],
      identityNumber: json["identityNumber"],
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
      "password": password,
      "roles": userRole?.name
    };
  }
}

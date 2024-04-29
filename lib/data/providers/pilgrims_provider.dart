import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/repositories/pilgrims_repository.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '/data/network/data_response.dart';
import '/data/models/user.dart';
import '/data/di/service_locator.dart';

class PilgrimsProvider extends ChangeNotifier {
  final _pilgrimsRepository = getIt.get<PilgrimsRepository>();

  PilgrimsProvider(this._user);

  final User? _user;
  List<Pilgrim?> adsPilgrims = [
    Pilgrim(
      name: "Ahmed",
      address: "Cairo",
      phone: "01000000000",
      supervisorPhone: "01000000000",
      healthStatus: "Good",
      healthProblem: "None",
      id: 1,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Mohamed",
      address: "Giza",
      phone: "01111111111",
      supervisorPhone: "01111111111",
      healthStatus: "Good",
      healthProblem: "None",
      id: 2,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Ali",
      address: "Alex",
      phone: "01222222222",
      supervisorPhone: "01222222222",
      healthStatus: "Good",
      healthProblem: "None",
      id: 3,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
  ];
  List<Pilgrim> _pilgrims = [
    Pilgrim(
      name: "Ahmed",
      address: "Cairo",
      phone: "01000000000",
      supervisorPhone: "01000000000",
      healthStatus: "Good",
      healthProblem: "None",
      id: 1,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Mohamed",
      address: "Giza",
      phone: "01111111111",
      supervisorPhone: "01111111111",
      healthStatus: "Good",
      healthProblem: "None",
      id: 2,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Ali",
      address: "Alex",
      phone: "01222222222",
      supervisorPhone: "01222222222",
      healthStatus: "Good",
      healthProblem: "None",
      id: 3,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
  ];
  List<Pilgrim> pilgrims = [
    Pilgrim(
      name: "Ahmed",
      address: "Cairo",
      phone: "01000000000",
      supervisorPhone: "01000000000",
      healthStatus: "Good",
      healthProblem: "None",
      id: 1,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Mohamed",
      address: "Giza",
      phone: "01111111111",
      supervisorPhone: "01111111111",
      healthStatus: "Good",
      healthProblem: "None",
      id: 2,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
    Pilgrim(
      name: "Ali",
      address: "Alex",
      phone: "01222222222",
      supervisorPhone: "01222222222",
      healthStatus: "Good",
      healthProblem: "None",
      id: 3,
      userID: 1,
      status: PilgrimStatus.none,
      url: "https://th.bing.com/th/id/OIP.0miyOJMoCeGLhaeCAYQiDwHaHa?rs=1&pid=ImgDetMain",
    ),
  ];
  Pilgrim? pilgrim;
}

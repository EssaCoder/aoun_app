import 'package:aoun/data/network/api/auth_api.dart';
import 'package:aoun/data/network/api/pilgrims_api.dart';
import 'package:aoun/data/repositories/auth_repository.dart';
import 'package:aoun/data/repositories/pilgrims_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(AuthApi());
  getIt.registerSingleton(AuthRepository(getIt.get<AuthApi>()));
  getIt.registerSingleton(PilgrimsApi());
  getIt.registerSingleton(PilgrimsRepository(getIt.get<PilgrimsApi>()));

}

import 'package:shared_preferences/shared_preferences.dart';

import 'preference_variable.dart';


class Preferences {
  Preferences._privateConstructor();
  static final Preferences _instance = Preferences._privateConstructor();
  static Preferences get instance => _instance;

  Future<void> insert(String key,String value) async {
    final prefs = await SharedPreferences.getInstance();
   await prefs.setString(key, value);
   return Future.value();
  }
  Future<bool> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
  Future<Object?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }


}
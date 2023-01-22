import 'dart:convert';

import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/providers/pilgrims_provider.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/views/home/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/style/theme_app.dart';
import 'package:provider/provider.dart';

import 'data/di/service_locator.dart';
import 'data/local/sharedpref_helper/preference_variable.dart';
import 'data/local/sharedpref_helper/preferences.dart';
import 'data/models/user.dart';
import 'data/providers/app_state_manager.dart';
import 'firebase_options.dart';
import 'views/auth/auth_screen.dart';
//TODO: Configuration iOS flutter_barcode_scanner

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final preferences = Preferences.instance;
  String? date = (await preferences.get(PreferenceVariable.user))?.toString();
  User? user = date == null ? null : User.fromJson(jsonDecode(date));
  if(user?.userRole==UserRole.disable){
    user=null;
  }
  setup();
  runApp(EasyLocalization(
    fallbackLocale: const Locale('ar', 'SA'),
    startLocale: const Locale('en', 'US'),
    saveLocale: true,
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
    path: 'assets/translations',
    child: MyApp(user: user),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.user});
  final User? user;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateManager()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..setUser(user)),
        ChangeNotifierProxyProvider<AuthProvider, PilgrimsProvider>(
            create: (context) => PilgrimsProvider(
                Provider.of<AuthProvider>(context, listen: false).user),
            update: (context, auth, _) => PilgrimsProvider(auth.user)),],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.light,
        // home: const TestScreen(),
        home: user == null ? const AuthScreen() : const MainScreen(),
        // home: const MainScreen(),
        // home: const VerifyOTP(),
      ),
    );
  }
}

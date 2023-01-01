import 'package:aoun/views/home/main_screen.dart';
import 'package:aoun/views/home/profile_page.dart';
import 'package:aoun/views/auth/users_screen.dart';
import 'package:aoun/views/pilgrims/add_pilgrims.dart';
import 'package:aoun/views/pilgrims/pilgrim_details.dart';
import 'package:aoun/views/pilgrims/view_pilgrims.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/style/theme_app.dart';
import 'package:provider/provider.dart';

import 'data/di/service_locator.dart';
import 'data/providers/app_state_manager.dart';
import 'views/auth/auth_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setup();
  runApp(EasyLocalization(
    fallbackLocale: const Locale('ar', 'SA'),
    startLocale: const Locale('en', 'US'),
    saveLocale: true,
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
    path: 'assets/translations',
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateManager()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.light,
        // home: const TestScreen(),
        // home:  const AuthScreen(),
        home: const MainScreen(),
      ),
    );
  }
}

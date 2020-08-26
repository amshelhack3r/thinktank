import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/screens/home.dart';
import 'package:think_tank/screens/login.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isProfileSelected = prefs.containsKey("isFirstTime");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP',
      home: isProfileSelected ? Home() : Login(),
    ),
  );
}

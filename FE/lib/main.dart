import 'package:flutter/material.dart';
import 'package:login_ui/Feature/Home/home.dart';
import 'package:login_ui/Feature/Register%20Screen/Register_Screen.dart';

import 'Feature/Login Screen/Login_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Project',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginScreen(),
    );
  }
}

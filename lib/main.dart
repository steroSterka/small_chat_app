import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:small_chat_app/pages/login/login_page.dart';
import 'package:small_chat_app/pages/register/register_page.dart';
import 'package:small_chat_app/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginPage(),
      theme: lightTheme,
    );
  }
}

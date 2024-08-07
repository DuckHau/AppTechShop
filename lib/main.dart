// 🐦 Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/Core/Theme/app_theme.dart';
import 'package:techshop_app/module/Auth/Binding/auth_binding.dart';
import 'Routes/app_pages.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TechShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: MyAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      initialBinding: AuthBinding(),
      initialRoute: AppPages.INITIAL,
    );
  }
}

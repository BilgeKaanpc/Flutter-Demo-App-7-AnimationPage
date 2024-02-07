import 'package:animation_page_app/menu_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Menu Dashboard",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.blue),
      ),
      home: const MenuDashboard(),
    );
  }
}

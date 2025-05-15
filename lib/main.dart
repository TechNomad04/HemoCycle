import 'package:flutter/material.dart';
import 'package:hemocycle/pages/home_page.dart';
import 'package:hemocycle/utils/navigation_bar.dart';


void main() {
  runApp(const HemoCycleApp());
}

class HemoCycleApp extends StatelessWidget {
  const HemoCycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  NavigationController(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}



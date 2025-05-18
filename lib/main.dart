import 'package:flutter/material.dart';
import 'package:hemocycle/pages/home_page.dart';
import 'package:hemocycle/utils/navigation_bar.dart';
import 'pages/welcome_pg.dart';
import 'pages/result_pg.dart';


void main() {
  runApp(const HemoCycleApp());
}

class HemoCycleApp extends StatelessWidget {
  const HemoCycleApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'HemoCycle App',
  initialRoute: '/',
  routes: {
  '/': (context) => WelcomePage(),
  '/home': (context) => HomePage(),
  '/results': (context) => ResultPage(),
  },
  );
  }
  }

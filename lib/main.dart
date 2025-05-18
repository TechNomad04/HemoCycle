import 'package:flutter/material.dart';
import 'pages/welcome_pg.dart';
import 'pages/result_pg.dart';

void main() => runApp(const HemoCycle());

class HemoCycle extends StatelessWidget {
  const HemoCycle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

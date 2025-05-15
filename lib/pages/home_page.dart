import 'package:flutter/material.dart';

import '../utils/custom container.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleTrackCycle() {
    print("Track Cycle icon pressed!");
    // Navigate or show a dialog here
  }

  void _handleHealthTips() {
    print("Health Tips icon pressed!");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hey\nBeautiful,"
              ,style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
            ),
          Center(
            child: Image.asset('assets/images/avatar.png',
              height: 350),
          ),
        CustomInfoContainer(
        title: "Track Cycle",
        subtitle: "Monitor your monthly cycle here",

        color: Colors.white54,
          onIconPressed: _handleTrackCycle,
          icon: Icons.camera,
      ),
      CustomInfoContainer(
        title: "Health Tips",
        subtitle: "Get daily wellness advice",
        icon: Icons.explore,
        color: Colors.white54,
        onIconPressed: _handleHealthTips,
      ),

      ],
        ),

      ),



    );
  }
}

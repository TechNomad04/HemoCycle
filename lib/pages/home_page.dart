import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../utils/custom container.dart';
import 'package:hemocycle/pages/upload_pg.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({super.key, required this.cameras});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleTrackCycle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPage(cameras: widget.cameras),
      ),
    );
  }

  void _handleHealthTips() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon!')),
    );
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.redAccent,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hey\nBeautiful,",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Image.asset(
                  'assets/images/avatar.png',
                  height: 200,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  CustomInfoContainer(
                    title: "Track Cycle",
                    subtitle: "Monitor your monthly cycle here",
                    color: Colors.white54,
                    icon: Icons.camera_alt,
                    onIconPressed: _handleTrackCycle,
                  ),
                  const SizedBox(height: 10),
                  CustomInfoContainer(
                    title: "Health Tips",
                    subtitle: "Get daily wellness advice",
                    color: Colors.white54,
                    icon: Icons.health_and_safety,
                    onIconPressed: _handleHealthTips,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

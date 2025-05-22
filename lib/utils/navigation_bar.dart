import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hemocycle/pages/About_us.dart';
import 'package:hemocycle/pages/home_page.dart';
import 'package:hemocycle/pages/profile_page.dart';

class NavigationController extends StatefulWidget {
  final List<CameraDescription> cameras;

  const NavigationController({super.key, required this.cameras});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(cameras: widget.cameras),
      AboutUs(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.pink,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'About Us'),
        ],
      ),
    );
  }
}

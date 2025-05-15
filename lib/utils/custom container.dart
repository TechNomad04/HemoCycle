import 'package:flutter/material.dart';

class CustomInfoContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onIconPressed;
  final IconData icon;


  const CustomInfoContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          IconButton(
          icon: Icon(icon, color: Colors.white),
      onPressed: onIconPressed,
      iconSize: 30,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[500])),
              const SizedBox(height: 5),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.brown)),
            ],
          ),
        ],
      ),
    );
  }
}
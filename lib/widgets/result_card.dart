import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String status;
  final String imagePath;

  const ResultCard({
    super.key,
    required this.title,
    required this.status,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 80),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          status,
          style: TextStyle(
            color: status == 'Normal' ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }
}

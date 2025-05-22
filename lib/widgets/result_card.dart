import 'dart:io';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String status;
  final String? imagePath;
  final File? imageFile;

  const ResultCard({
    super.key,
    required this.title,
    required this.status,
    this.imagePath,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = imageFile != null
        ? Image.file(imageFile!, width: 80)
        : (imagePath != null
        ? Image.asset(imagePath!, width: 80)
        : const Icon(Icons.image, size: 80));

    return Column(
      children: [
        imageWidget,
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

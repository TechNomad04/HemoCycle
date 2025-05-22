import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String status;
  final String? imagePath;
  final File? imageFile;
  final Uint8List? webImageBytes;

  const ResultCard({
    super.key,
    required this.title,
    required this.status,
    this.imagePath,
    this.imageFile,
    this.webImageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget;

    if (kIsWeb && webImageBytes != null) {
      imageWidget = Image.memory(webImageBytes!, width: 80);
    } else if (imageFile != null) {
      imageWidget = Image.file(imageFile!, width: 80);
    } else if (imagePath != null) {
      imageWidget = Image.asset(imagePath!, width: 80);
    } else {
      imageWidget = const Icon(Icons.image, size: 80);
    }

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

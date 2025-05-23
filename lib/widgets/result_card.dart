import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ResultCard extends StatelessWidget {
  final String title;
  final String status;
  final File? imageFile;
  final Uint8List? imageBytes;

  const ResultCard({
    super.key,
    required this.title,
    required this.status,
    this.imageFile,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (kIsWeb && imageBytes != null) {
      imageWidget = Image.memory(imageBytes!, height: 100, fit: BoxFit.cover);
    } else if (!kIsWeb && imageFile != null) {
      imageWidget = Image.file(imageFile!, height: 100, fit: BoxFit.cover);
    } else {
      imageWidget = const Icon(Icons.image, size: 80, color: Colors.grey);
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imageWidget,
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: status.toLowerCase().contains('anemia') ? Colors.red : Colors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

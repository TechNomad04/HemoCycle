import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../widgets/page_header.dart';
import '../widgets/result_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    // For Web, decode base64 string to bytes
    Uint8List? imageBytes;
    File? uploadedImage;

    String? base64String = args?['imageBase64'];

    if (kIsWeb && base64String != null) {
      imageBytes = base64Decode(base64String);
    } else {
      uploadedImage = args?['image'];
    }

    final String analysis = args?['analysis'] ?? 'Unknown';
    final String region = args?['region'] ?? 'N/A';
    final String recommendation = args?['recommendation'] ?? '';

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Your Results'),
        backgroundColor: Colors.redAccent,
      ),
      body: (kIsWeb && imageBytes == null) || (!kIsWeb && uploadedImage == null)
          ? const Center(child: Text('No image provided.'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(title: 'Here’s What We Found'),
            const SizedBox(height: 20),

            // Display Uploaded Image (memory for web, file for others)
            Center(
              child: kIsWeb
                  ? Image.memory(imageBytes!, height: 200)
                  : Image.file(uploadedImage!, height: 200),
            ),
            const SizedBox(height: 20),

            // Result Summary
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: [
                ResultCard(
                  title: region,
                  status: analysis,
                  imageFile: uploadedImage,
                  imageBytes: imageBytes,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recommendation Section
            if (recommendation.isNotEmpty)
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    recommendation,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Action Buttons
            Center(
              child: Wrap(
                spacing: 12.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to tracking page
                    },
                    child: const Text('Track My Health'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to info page
                    },
                    child: const Text('Learn More'),
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
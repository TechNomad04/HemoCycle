import 'dart:io';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> resultData;

  const ResultPage({super.key, required this.resultData});

  @override
  Widget build(BuildContext context) {
    final File imageFile = resultData['image'];
    final String analysis = resultData['analysis'];
    final String region = resultData['region'];
    final String recommendation = resultData['recommendation'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis Result"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.file(imageFile, height: 200),
            const SizedBox(height: 20),
            _buildResultTile("Diagnosis", analysis),
            _buildResultTile("Affected Region", region),
            _buildResultTile("Recommendation", recommendation),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Retake Photo"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultTile(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

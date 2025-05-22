import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:camera/camera.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const UploadPage({super.key, required this.cameras});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  late CameraController _controller;
  late Future<void> _initCamera;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
    );
    _initCamera = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    try {
      await _initCamera;
      final XFile image = await _controller.takePicture();
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  void _goToResults() async {
    if (_capturedImage == null) return;

    if (kIsWeb) {
      // Read image bytes on Web and convert to base64 string
      Uint8List bytes = await _capturedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);
      final resultData = {
        'imageBase64': base64Image,
        'analysis': 'Mild Anemia',
        'region': 'Lower Eyelids',
        'recommendation': 'Try more leafy greens and iron-rich foods.',
      };
      Navigator.pushNamed(context, '/results', arguments: resultData);
    } else {
      // For mobile and others, pass the file path
      final resultData = {
        'image': File(_capturedImage!.path),
        'analysis': 'Mild Anemia',
        'region': 'Lower Eyelids',
        'recommendation': 'Try more leafy greens and iron-rich foods.',
      };
      Navigator.pushNamed(context, '/results', arguments: resultData);
    }
  }


  Widget _buildImagePreview() {
    if (_capturedImage == null) {
      return Container(
        height: 250,
        width: double.infinity,
        color: Colors.pink[100],
        child: const Icon(Icons.photo_camera, size: 100, color: Colors.white),
      );
    }

    return kIsWeb
        ? Image.network(_capturedImage!.path, height: 250)
        : Image.file(File(_capturedImage!.path), height: 250);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Photo'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: _initCamera,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera),
                      label: const Text("Take Photo"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    ),
                    const SizedBox(height: 20),
                    _buildImagePreview(),
                    const SizedBox(height: 20),
                    if (_capturedImage != null)
                      ElevatedButton(
                        onPressed: _goToResults,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("View Results"),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

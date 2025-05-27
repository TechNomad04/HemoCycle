import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
  bool _isAnalyzing = false;

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

  Future<void> _analyzeOfflineMock() async {
    if (_capturedImage == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // simulate processing time

    final results = [
      {
        'analysis': 'Anemic',
        'region': 'Lower Conjunctiva',
        'recommendation': 'Consider iron supplements and blood test'
      },
      {
        'analysis': 'Non-Anemic',
        'region': 'Healthy Eye Region',
        'recommendation': 'No action needed'
      }
    ];

    final mockResult = results[Random().nextInt(results.length)];

    final resultData = {
      'image': File(_capturedImage!.path),
      'analysis': mockResult['analysis'],
      'region': mockResult['region'],
      'recommendation': mockResult['recommendation'],
    };

    setState(() {
      _isAnalyzing = false;
    });

    Navigator.pushNamed(context, '/results', arguments: resultData);
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

    return Image.file(File(_capturedImage!.path), height: 250);
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
                      _isAnalyzing
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: _analyzeOfflineMock,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Analyze Image"),
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


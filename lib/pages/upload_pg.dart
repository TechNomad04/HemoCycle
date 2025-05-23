import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

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
  bool _isUploading = false;

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

  Future<void> _sendImageToAPI() async {
    if (_capturedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final uri = Uri.parse('http://localhost:8000/predict'); // change IP if needed
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('file', _capturedImage!.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final resultData = {
          'image': File(_capturedImage!.path),
          'analysis': data['analysis'] ?? 'No analysis',
          'region': data['region'] ?? 'Unknown region',
          'recommendation': data['recommendation'] ?? 'No recommendation',
        };

        Navigator.pushNamed(context, '/results', arguments: resultData);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
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
                      _isUploading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: _sendImageToAPI,
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

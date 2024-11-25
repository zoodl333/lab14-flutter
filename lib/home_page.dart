import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'time_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example/native_code');

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showTimeDialog(context),
              child: const Text('Show Current Time'),
            ),
            const SizedBox(height: 20),
            if (_image != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Image.file(_image!, height: 500),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Open Camera',
        child: const Icon(Icons.camera),
      ),
    );
  }

  Future<void> _showTimeDialog(BuildContext context) async {
    String time;
    try {
      time = await platform.invokeMethod('getCurrentTime');
    } on PlatformException catch (e) {
      time = "Failed to get time: '${e.message}'.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TimeDialog(time: time);
      },
    );
  }
}
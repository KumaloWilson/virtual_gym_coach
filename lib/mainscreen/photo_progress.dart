import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class ProgressPhotoScreen extends StatefulWidget {
  @override
  _ProgressPhotoScreenState createState() => _ProgressPhotoScreenState();
}

class _ProgressPhotoScreenState extends State<ProgressPhotoScreen> {
  List<XFile> photos = []; // List to store the captured or selected photos

  void _viewPhoto(XFile photo) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.file(
              File(photo.path),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  Future<void> _capturePhoto() async {
    final cameras = await availableCameras(); // Get available cameras
    final camera = cameras.first; // Use the first available camera

    final XFile photo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePhotoScreen(camera: camera),
      ),
    );

    if (photo != null) {
      setState(() {
        photos.add(photo);
      });
      _viewPhoto(photo); // Call the _viewPhoto function to view the captured photo
    }
  }

  Future<void> _selectPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() {
        photos.add(photo);
      });
      _viewPhoto(photo); // Call the _viewPhoto function to view the selected photo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Photos'),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              _viewPhoto(photos[index]); // Call the _viewPhoto function on onTap
            },
            leading: Image.file(
              File(photos[index].path),
              width: 50,
              height: 50,
            ),
            title: Text('Photo ${index + 1}'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _capturePhoto,
            tooltip: 'Take Photo',
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _selectPhoto,
            tooltip: 'Select Photo',
            child: Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}

class TakePhotoScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePhotoScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Photo'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final XFile photo = await _controller.takePicture();
            Navigator.pop(context, photo);
          } catch (e) {
            print('Error capturing photo: $e');
          }
        },
      ),
    );
  }
}

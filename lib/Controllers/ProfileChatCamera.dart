import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final CameraController controller;
  // Updated to accept String argument

  CameraScreen(this.controller);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: CameraPreview(widget.controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final XFile file = await widget.controller.takePicture();
            Navigator.pop(context, file.path); // Return image path to the previous screen
          } catch (e) {
            print("Error occurred while capturing photo: $e");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error capturing photo. Please try again.'),
            ));
          }
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

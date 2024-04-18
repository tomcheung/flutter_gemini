import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

List<CameraDescription>? _cameras;

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();

    Future<CameraController> loadCameraController;
    if (_cameras != null) {
      loadCameraController =
          Future.value(CameraController(_cameras![0], ResolutionPreset.max, enableAudio: false));
    } else {
      loadCameraController = availableCameras().then((cameras) {
        _cameras = cameras;
        return CameraController(cameras[0], ResolutionPreset.medium, enableAudio: false);
      });
    }

    loadCameraController.then((contorller) {
      _controller = contorller;
      return contorller.initialize();
    }).then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    Widget child;
    if (controller != null) {
      child = CameraPreview(controller);
    } else {
      child = Center(child: const CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(),
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final image = await _controller?.takePicture();
          if (image == null) {
            return;
          }

          if (context.mounted) {
            Navigator.pop(context, image);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

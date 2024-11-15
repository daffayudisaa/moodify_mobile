import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/pages/displaypicture_page.dart';
import 'package:moodify_mobile/pages/preparescan_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  // Initialize with a Future that completes immediately
  Future<void> _initializeControllerFuture = Future.value();
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    // Set the future immediately in initState
    _initializeControllerFuture = _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        return _initializeCamera(cameras![selectedCameraIndex]);
      } else {
        throw CameraException(
            'No cameras found', 'No cameras available on device');
      }
    } catch (e) {
      print("Error initializing cameras: $e");
      rethrow;
    }
  }

  Future<void> _initializeCamera(CameraDescription cameraDescription) async {
    final CameraController previousController = _controller ??
        CameraController(
          widget.camera,
          ResolutionPreset.medium,
          enableAudio: false,
        );

    if (previousController != _controller) {
      _controller?.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      _controller = cameraController;
      await cameraController.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
      if (mounted) {
        setState(() {
          _controller = null;
        });
      }
      rethrow;
    }
  }

  void _flipCamera() async {
    if (cameras == null || cameras!.length <= 1) return;

    final int nextIndex = (selectedCameraIndex + 1) % cameras!.length;

    setState(() {
      selectedCameraIndex = nextIndex;
    });

    _initializeControllerFuture = _initializeCamera(cameras![nextIndex]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controller?.value.isInitialized != true) {
            return const Center(
              child: Text('Camera not initialized',
                  style: TextStyle(color: Colors.black)),
            );
          }

          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 320,
                height: 480,
                child: CameraPreview(_controller!),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Take a Picture',
          style: TextStyle(
            color: Color(0xFF004373),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          if (cameras != null && cameras!.length > 1)
            IconButton(
              icon: const Icon(
                Icons.cameraswitch,
                color: Color(0xFF004373),
              ),
              onPressed:
                  _controller?.value.isInitialized == true ? _flipCamera : null,
            ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF004373), // Blue color for the back button
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PreparescanPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.white,
                child: _buildCameraPreview(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  if (_controller?.value.isInitialized != true) return;

                  try {
                    final image = await _controller!.takePicture();

                    if (!context.mounted) return;

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print("Error taking picture: $e");
                  }
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.blue.withOpacity(0.5), width: 5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

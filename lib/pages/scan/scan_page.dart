import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/pages/scan/displaypicture_page.dart';
import 'package:moodify_mobile/pages/scan/preparescan_page.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.7
            : 1.5;

    double previewSize = 320 * multiplier;
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
                width: previewSize,
                height: previewSize * 1.5,
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
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Take a Picture',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: getFontSize * 1.5,
            color: const Color(0xFF004373),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          if (cameras != null && cameras!.length > 1)
            IconButton(
              icon: Icon(
                Icons.cameraswitch,
                color: const Color(0xFF004373),
                size: getFontSize * 1.7,
              ),
              onPressed:
                  _controller?.value.isInitialized == true ? _flipCamera : null,
            ),
        ],
        leading: IconButton(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            color: const Color(0xFF004373),
            size: getFontSize * 1.8,
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

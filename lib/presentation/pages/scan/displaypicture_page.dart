import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final bool isFrontCamera; // Add this field to indicate the camera type

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    required this.isFrontCamera, // Initialize this field
  });

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isLoading = false;

  Future<void> _uploadImage() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() async {
  bool? confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/Accept.jpg',
              height: 70,
              width: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            const Text(
              'Success',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            'Gambar berhasil diunggah!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 30),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true); // Dikonfirmasi 'true'
                  Navigator.pushNamedAndRemoveUntil(
                    context, '/navbar', (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF009951), 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.withOpacity(0.2)), 
                  ),
                  shadowColor: Colors.transparent, 
                  elevation: 0, 
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.0;
    double getFontSize = 14 * multiplier;
    double getImageSize = 30.5 * multiplier;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Display the Picture',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: getFontSize * 1.5,
            color: const Color(0xFF004373),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            color: const Color(0xFF004373),
            size: getFontSize * 1.8,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: widget.isFrontCamera
                  ? Matrix4.rotationY(
                      3.14159) // Apply mirror effect if front camera
                  : Matrix4
                      .identity(), // Keep normal orientation for back camera
              child: Image.file(
                height: getImageSize * 19,
                File(widget.imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 40),
          if (_isLoading) const CircularProgressIndicator(color: Colors.blue),
          if (!_isLoading)
            TextButton(
              onPressed: _uploadImage,
              child: Text(
                'Kirim',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSize * 1.2,
                ),
              ),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: const Color(0xFF42B1FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

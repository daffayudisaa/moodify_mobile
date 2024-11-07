import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/widgets/navbar.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Pass the first available camera to Navbar
      home: Navbar(camera: cameras.first),
    );
  }
}

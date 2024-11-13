import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/pages/auth/sign_in.dart';
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
      home: SignInPage(),
      routes: {
        '/navbar': (context) => Navbar(camera: cameras.first),
        '/signin': (context) => const SignInPage(),
      },
    );
  }
}

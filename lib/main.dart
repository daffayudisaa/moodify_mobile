import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/pages/auth/sign_in.dart';
import 'package:moodify_mobile/pages/scan/scan_page.dart';
import 'package:moodify_mobile/widgets/navbar.dart';
import 'package:moodify_mobile/widgets/splash_screen.dart';

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
      home: const SplashScreen(),
      routes: {
        '/navbar': (context) {
          final initialTab =
              ModalRoute.of(context)?.settings.arguments as int? ?? 0;
          return Navbar(camera: cameras.first, initialTab: initialTab);
        },
        '/signin': (context) => const SignInPage(),
        '/scan': (context) => ScanPage(camera: cameras.first),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/music/music_bloc.dart';
import 'package:moodify_mobile/presentation/pages/auth/sign_in.dart';
import 'package:moodify_mobile/presentation/pages/change_password/change_password.dart';
import 'package:moodify_mobile/presentation/pages/scan/scan_page.dart';
import 'package:moodify_mobile/presentation/widgets/navbar.dart';
import 'package:moodify_mobile/presentation/widgets/splash_screen.dart';

late final List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint('Error initializing cameras: $e');
    cameras = [];
  }

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ChangePasswordBloc>(
          create: (context) => ChangePasswordBloc(),
        ),
        BlocProvider<MusicBloc>(
          create: (context) => MusicBloc(),
        ),
        // Tambahkan Bloc lainnya di sini jika diperlukan
      ],
      child: MaterialApp(
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
            return cameras.isNotEmpty
                ? Navbar(camera: cameras.first, initialTab: initialTab)
                : const Scaffold(
                    body: Center(
                      child: Text('No cameras available'),
                    ),
                  );
          },
          '/signin': (context) => const SignInPage(),
          '/change_password': (context) => const ChangePasswordPage(),
          '/scan': (context) => cameras.isNotEmpty
              ? ScanPage(camera: cameras.first)
              : const Scaffold(
                  body: Center(
                    child: Text('No cameras available'),
                  ),
                ),
        },
      ),
    );
  }
}

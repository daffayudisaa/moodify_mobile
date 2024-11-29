import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.pushNamedAndRemoveUntil(
          context, '/signin', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: const Image(
                  image: AssetImage('assets/images/Moodify-Logo1.png')),
            ),
            const Text('Moodify',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF42B1FF))),
          ],
        ),
      ),
    );
  }
}

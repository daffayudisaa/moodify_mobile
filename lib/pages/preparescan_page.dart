import 'package:flutter/material.dart';

class PreparescanPage extends StatelessWidget {
  const PreparescanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: const Text(
          'Prepare Yourself!',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF004373)),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/AvatarDo.png'),
                        width: 131,
                      ),
                      SizedBox(height: 10),
                      Image(
                        image: AssetImage('assets/icons/Do.png'),
                        width: 95,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/AvatarDont.png'),
                        width: 131,
                      ),
                      SizedBox(height: 10),
                      Image(
                          image: AssetImage('assets/icons/Dont.png'),
                          width: 95),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Before we start scanning your face, here’s what you need to do:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), // Spasi antar teks
                  Text(
                    '• Ditch the Accessories: Take off your glasses, hats, or anything that might hide your face.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5), // Spasi antar poin
                  Text(
                    '• Find Good Lighting: Make sure you’re in a bright spot—no harsh shadows, please!',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Face the Camera: Look straight at the camera for the best results.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Stay Chill: Keep still while we scan your face—just relax!',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Pick a Simple Background: Choose a clean, uncluttered backdrop to help us see you better.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/scan', (Route<dynamic> route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0096FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 96, vertical: 15),
              ),
              child: const Text(
                "Scan My Face!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';

class PreparescanPage extends StatelessWidget {
  const PreparescanPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.7
            : 1.5;

    double titleFontSize = 14 * multiplier;
    double imageSize = 130 * multiplier;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Text(
          'Prepare Yourself!',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: titleFontSize * 1.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF004373)),
        ),
        leading: IconButton(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            color: const Color(0xFF004373),
            size: titleFontSize * 1.8,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(
                context, '/navbar', (Route<dynamic> route) => false);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image(
                        image: const AssetImage('assets/images/AvatarDo.png'),
                        width: imageSize * 1.1,
                      ),
                      const SizedBox(height: 10),
                      Image(
                        image: const AssetImage('assets/icons/Do.png'),
                        width: imageSize * 0.7,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                        image: const AssetImage('assets/images/AvatarDont.png'),
                        width: imageSize * 1.1,
                      ),
                      const SizedBox(height: 10),
                      Image(
                          image: const AssetImage('assets/icons/Dont.png'),
                          width: imageSize * 0.7),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Before we start scanning your face, here’s what you need to do:',
                    style: TextStyle(
                        fontSize: titleFontSize * 1,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), // Spasi antar teks
                  Text(
                    '• Ditch the Accessories: Take off your glasses, hats, or anything that might hide your face.',
                    style: TextStyle(fontSize: titleFontSize * 0.9),
                  ),
                  const SizedBox(height: 5), // Spasi antar poin
                  Text(
                    '• Find Good Lighting: Make sure you’re in a bright spot—no harsh shadows, please!',
                    style: TextStyle(fontSize: titleFontSize * 0.9),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '• Face the Camera: Look straight at the camera for the best results.',
                    style: TextStyle(fontSize: titleFontSize * 0.9),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '• Stay Chill: Keep still while we scan your face—just relax!',
                    style: TextStyle(fontSize: titleFontSize * 0.9),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '• Pick a Simple Background: Choose a clean, uncluttered backdrop to help us see you better.',
                    style: TextStyle(fontSize: titleFontSize * 0.9),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: imageSize * 2.3,
              child: const Row(
                children: [
                  Expanded(
                    child: FillButtonRoute(
                        route: '/scan',
                        color: Color(0xFF42B1FF),
                        text: 'Scan My Face!'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

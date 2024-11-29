import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/presentation/pages/home/home_page.dart';
import 'package:moodify_mobile/presentation/pages/music_recom/music_recom_page.dart';
import 'package:moodify_mobile/presentation/pages/scan/preparescan_page.dart';
import 'package:moodify_mobile/presentation/pages/profile/profile.dart';
import 'package:moodify_mobile/presentation/pages/recap_mood/recap_mood.dart';

class Navbar extends StatefulWidget {
  final CameraDescription camera;
  final int initialTab;

  const Navbar({super.key, required this.camera, this.initialTab = 0});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int currentTab;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    currentTab = widget.initialTab;
    screens = [
      const HomePage(userMood: 'happy'),
      const RecapMoodPage(),
      const MusicRecomPage(userMood: 'sad'),
      const ProfilePage(),
    ];
    currentScreen = screens[currentTab];
  }

  double _getIconSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 400) {
      return 28.0;
    } else {
      return 25.0;
    }
  }

  double _getTextSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 14.0;
    } else {
      return 11.0;
    }
  }

  double _getBottomBarHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight > 600) {
      return 95.0;
    } else if (screenHeight > 400) {
      return 80.0;
    }
    return 70.0;
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = _getIconSize(context);
    double textSize = _getTextSize(context);
    double bottomBarHeight = _getBottomBarHeight(context);
    double fabSize = MediaQuery.of(context).size.width * 0.15;
    fabSize = fabSize.clamp(45.0, 65.0);

    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: isKeyboardOpen
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  height: fabSize,
                  width: fabSize,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    splashColor: Colors.transparent,
                    child: Image(
                      image: const AssetImage('assets/icons/navbar/Scan.png'),
                      color: Colors.white,
                      width: iconSize * 1.4,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PreparescanPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.black,
        elevation: 15,
        color: Colors.white,
        child: Container(
          height: bottomBarHeight,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, 'assets/icons/navbar/Home.png', "Home",
                        iconSize * 1.1, textSize),
                    _buildNavItem(1, 'assets/icons/navbar/Recap-Mood.png',
                        "Recap", iconSize * 1.15, textSize),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.25),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(2, 'assets/icons/navbar/Music-Recom.png',
                        "Music", iconSize * 1.1, textSize),
                    _buildNavItem(3, 'assets/icons/navbar/Profile.png',
                        "Profile", iconSize * 1.1, textSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label,
      double iconSize, double textSize) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      minWidth: 40,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      onPressed: () {
        setState(() {
          currentScreen = screens[index];
          currentTab = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: iconSize,
            height: iconSize,
            color: currentTab == index ? Colors.blue : Colors.grey.shade400,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: textSize,
              color: currentTab == index ? Colors.blue : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

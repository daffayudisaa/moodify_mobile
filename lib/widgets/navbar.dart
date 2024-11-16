import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:moodify_mobile/pages/home_page.dart';
import 'package:moodify_mobile/pages/music_recom_page.dart';
import 'package:moodify_mobile/pages/preparescan_page.dart';
import 'package:moodify_mobile/pages/profile.dart';
import 'package:moodify_mobile/pages/recap_mood.dart';
import 'package:hugeicons/hugeicons.dart';

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
      const HomePage(),
      const RecapMoodPage(),
      const MusicRecomPage(),
      const ProfilePage(),
    ];
    currentScreen = screens[currentTab];
  }

  double _getIconSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 34.0;
    } else if (screenWidth > 400) {
      return 30.0;
    }
    return 26.0;
  }

  double _getTextSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 15.0;
    } else if (screenWidth > 400) {
      return 13.0;
    }
    return 11.0;
  }

  double _getBottomBarHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight > 800) {
      return 90.0;
    } else if (screenHeight > 600) {
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

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SizedBox(
            height: fabSize,
            width: fabSize,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              splashColor: Colors.transparent,
              child: Icon(
                HugeIcons.strokeRoundedFaceId,
                color: Colors.white,
                size: iconSize * 1.2,
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
          Text(
            'Scan',
            style: TextStyle(
              color: Colors.grey,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
                    _buildNavItem(0, HugeIcons.strokeRoundedHome09, "Home",
                        iconSize, textSize),
                    _buildNavItem(1, HugeIcons.strokeRoundedDocumentValidation,
                        "Recap", iconSize, textSize),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.25),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(2, HugeIcons.strokeRoundedFolderMusic,
                        "Music", iconSize, textSize),
                    _buildNavItem(3, HugeIcons.strokeRoundedUser, "Profile",
                        iconSize, textSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, double iconSize,
      double textSize) {
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
          Icon(
            icon,
            size: iconSize,
            color: currentTab == index ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: textSize,
              color: currentTab == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

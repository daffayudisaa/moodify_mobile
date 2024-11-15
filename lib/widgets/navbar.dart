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
  final int initialTab; // New initialTab parameter to specify the default tab

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
    currentTab = widget.initialTab; // Set initial tab based on parameter
    screens = [
      const HomePage(),
      const RecapMoodPage(),
      const MusicRecomPage(),
      const ProfilePage(),
    ];
    currentScreen = screens[currentTab]; // Initialize currentScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            splashColor: Colors.transparent,
            child: Icon(
              HugeIcons.strokeRoundedFaceId,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PreparescanPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Scan',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedHome09,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = RecapMoodPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedDocumentValidation,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Recap",
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MusicRecomPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedFolderMusic,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Music",
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfilePage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedUser,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

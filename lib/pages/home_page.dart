import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/pages/recap_mood.dart';
import 'package:moodify_mobile/widgets/list/recom_song.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double fontSize = 13 * multiplier;
    double imageSize = 50 * multiplier;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            toolbarHeight: 120,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Hello Mita,",
                          style: TextStyle(
                            color: Color(0xFF004373),
                            fontSize: fontSize * 1.65,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "How was your day?",
                          style: TextStyle(
                            color: const Color(0xFF004373),
                            fontSize: fontSize * 1.25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/navbar',
                        (Route<dynamic> route) => false,
                        arguments: 3,
                      );
                    },
                    child: CircleAvatar(
                      radius: imageSize * 0.7,
                      backgroundImage:
                          const AssetImage('assets/images/User.jpg'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFA0D3F5),
                          Color(0xFFD9E9F8),
                        ]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Feeling Happy!",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: fontSize * 1.65,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Enjoy every moment!",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: fontSize * 1.1,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Wed, 10 September 2024",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: fontSize * 0.95,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image(
                                image: const AssetImage(
                                    'assets/meowdy/Meowdy-Happy.png'),
                                height: imageSize * 2.3,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(160, 211, 245, 0.30),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            "Happiness is when what you think, what you say, and what you do are in harmony.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: fontSize,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/navbar',
                          (Route<dynamic> route) => false,
                          arguments: 2,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              'Recommended Songs',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: fontSize * 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.black,
                              size: fontSize * 1.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const ListSongRecom(
                      images: 'assets/images/AlbumCover.jpg',
                      title: 'About You',
                      artist: 'The 1975',
                      duration: '5:26',
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/navbar',
                          (Route<dynamic> route) => false,
                          arguments: 1,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              'Recap Mood',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: fontSize * 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.black,
                              size: fontSize * 1.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 1200 ? 1.5 : 0.7,
                      children: const [
                        RecapMoodCard(
                          path: 'assets/meowdy/Meowdy-Happy.png',
                          mood: 'Happy',
                          count: 5,
                        ),
                        RecapMoodCard(
                          path: 'assets/meowdy/Meowdy-Happy.png',
                          mood: 'Sad',
                          count: 2,
                        ),
                        RecapMoodCard(
                          path: 'assets/meowdy/Meowdy-Happy.png',
                          mood: 'Angry',
                          count: 1,
                        ),
                        RecapMoodCard(
                          path: 'assets/meowdy/Meowdy-Happy.png',
                          mood: 'Surprised',
                          count: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

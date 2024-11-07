import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/pages/music_recom_page.dart';
import 'package:moodify_mobile/pages/recap_mood.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            toolbarHeight: 110,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          "Hello Mita,",
                          style: TextStyle(
                            color: Color(0xFF004373),
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "How was your day?",
                          style: TextStyle(
                            color: Color(0xFF004373),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: const CircleAvatar(
                      radius: 35,
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
                      height: 113,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFA0D3F5),
                          Color(0xFFD9E9F8),
                        ]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Feeling Happy!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Enjoy every moment, you deserve it!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Wednesday, 10 September 2024",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image(
                                image: AssetImage(
                                    'assets/meowdy/Meowdy-Happy.png'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(160, 211, 245, 0.23),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Happiness is when what you think, what you say, and what you do are in harmony.",
                            style: TextStyle(
                              fontSize: 14,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicRecomPage()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: const Row(
                          children: [
                            const Text(
                              'Recommended Songs',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: List.generate(
                        5,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/AlbumCover.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "About You",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "The 1975",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "5:26",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecapMoodPage()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: const Row(
                          children: [
                            Text(
                              'Recap Mood',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.black,
                              size: 20,
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
                      childAspectRatio: 0.7,
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

class RecapMoodCard extends StatelessWidget {
  final String path;
  final String mood;
  final int count;
  const RecapMoodCard({
    required this.path,
    required this.mood,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFA0D3F5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(path),
            height: 60,
            width: 60,
          ),
          Text(
            mood,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$count",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

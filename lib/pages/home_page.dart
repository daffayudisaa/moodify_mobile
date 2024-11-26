import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/widgets/cards/mood_card.dart';
import 'package:moodify_mobile/widgets/list/recom_song.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);
    double getImageSize = ScreenUtils.getImageSize(context, 50);

    void navigateToPage(int pageIndex) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/navbar',
        (Route<dynamic> route) => false,
        arguments: pageIndex,
      );
    }

    TextStyle textStyle(double fontSize,
        {Color color = Colors.black,
        FontWeight fontWeight = FontWeight.normal}) {
      return TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
    }

    Widget messageContainer(String message,
        {TextAlign textAlign = TextAlign.center}) {
      return Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(160, 211, 245, 0.30),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              message,
              style: textStyle(getFontSize),
              textAlign: textAlign,
            ),
          ),
        ),
      );
    }

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
                        Text("Hello Mita,",
                            style: textStyle(getFontSize * 1.65,
                                color: const Color(0xFF004373),
                                fontWeight: FontWeight.w400)),
                        Text("How was your day?",
                            style: textStyle(getFontSize * 1.25,
                                color: const Color(0xFF004373),
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => navigateToPage(3),
                      child: CircleAvatar(
                        radius: getImageSize * 0.7,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Feeling Happy!",
                                style: textStyle(getFontSize * 1.65,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            Text("Enjoy every moment!",
                                style: textStyle(getFontSize * 1.1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(height: 20),
                            Text("Wed, 10 September 2024",
                                style: textStyle(getFontSize * 0.95,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Image(
                          image: const AssetImage(
                              'assets/meowdy/Meowdy-Happy.png'),
                          height: getImageSize * 2.3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                messageContainer(
                  "Happiness is when what you think, what you say, and what you do are in harmony.",
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => navigateToPage(2),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text('Recommended Songs',
                            style: textStyle(getFontSize * 1.4,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 5),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        color: Colors.black,
                        size: getFontSize * 1.5,
                      ),
                    ],
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
                  onTap: () => navigateToPage(1),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text('Recap Mood',
                            style: textStyle(getFontSize * 1.4,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 5),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        color: Colors.black,
                        size: getFontSize * 1.5,
                      ),
                    ],
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
                        count: 5),
                    RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Happy.png',
                        mood: 'Sad',
                        count: 2),
                    RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Happy.png',
                        mood: 'Angry',
                        count: 1),
                    RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Happy.png',
                        mood: 'Surprised',
                        count: 1),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moodify_mobile/widgets/list/recom_song.dart';

class MusicRecomPage extends StatelessWidget {
  const MusicRecomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double titleFontSize = 14 * multiplier;
    double verticalPadding = 8 * multiplier;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Recomended Song',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: titleFontSize * 1.7,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004373),
                  ),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 30, vertical: verticalPadding),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        'Songs That Match With Your Mood',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: titleFontSize * 0.95,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const ListSongRecom(
                  total: 100,
                  additionSizeImage: 1.4,
                  additionSizeFont: 1.1,
                  images: 'assets/images/AlbumCover.jpg',
                  title: 'About You',
                  artist: 'The 1975',
                  duration: '5:26',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

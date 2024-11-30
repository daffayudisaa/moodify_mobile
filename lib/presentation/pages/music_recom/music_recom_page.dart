import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/mood_mapping.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/list/recom_song.dart';
import 'package:moodify_mobile/utils/song_filter.dart';

class MusicRecomPage extends StatefulWidget {
  final String userMood;

  const MusicRecomPage({Key? key, required this.userMood}) : super(key: key);

  @override
  State<MusicRecomPage> createState() => _MusicRecomPageState();
}

class _MusicRecomPageState extends State<MusicRecomPage> {
  late List<String> displayMoods;
  String selectedMood = 'All';

  @override
  void initState() {
    super.initState();

    displayMoods = ['All', ...moodMapping[widget.userMood.toLowerCase()] ?? []];
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getVerticalPadding = ScreenUtils.getImageSize(context, 8);

    List<Map<String, String>> filteredSongs = filterSongsByMood(
      selectedMood,
      displayMoods,
      songsByMood,
    );

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
                  'Recommended Song',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: getFontSize * 1.7,
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
                      horizontal: 30, vertical: getVerticalPadding),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Songs That Match With Your Mood',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getFontSize * 0.95,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: displayMoods.map((mood) {
                          return ChoiceChip(
                            showCheckmark: false,
                            backgroundColor: Colors.white,
                            selectedColor:
                                const Color(0xFFA0D3F5).withOpacity(0.6),
                            side: BorderSide(
                              color: const Color(0xFFA0D3F5).withOpacity(0.6),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text(
                              mood,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: getFontSize * 0.9,
                              ),
                            ),
                            selected: selectedMood == mood,
                            onSelected: (isSelected) {
                              setState(() {
                                selectedMood = isSelected ? mood : 'All';
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (filteredSongs.isNotEmpty)
                  Column(
                    children: filteredSongs.map((song) {
                      return ListSongRecom(
                        total: 1,
                        additionSizeImage: 1.4,
                        additionSizeFont: 1.1,
                        images: 'assets/images/AlbumCover.jpg',
                        title: song['title']!,
                        artist: song['artist']!,
                        duration: song['duration']!,
                      );
                    }).toList(),
                  )
                else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'No songs available for $selectedMood mood.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getFontSize,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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

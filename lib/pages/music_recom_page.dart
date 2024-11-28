import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/widgets/list/recom_song.dart';

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

    final Map<String, List<String>> moodMapping = {
      'sad': ['Sad', 'Calm'],
      'disgust': ['Energetic', 'Happy'],
      'angry': ['Energetic', 'Calm'],
      'fear': ['Happy', 'Calm'],
      'happy': ['Happy', 'Calm'],
      'surprise': ['Energetic', 'Sad'],
      '': ['Happy', 'Sad', 'Calm', 'Energetic']
    };

    displayMoods = ['All', ...moodMapping[widget.userMood.toLowerCase()] ?? []];
  }

  final Map<String, List<Map<String, String>>> songsByMood = {
    'Sad': [
      {'title': 'Sad Song 1', 'artist': 'Artist 1', 'duration': '4:30'},
      {'title': 'Sad Song 2', 'artist': 'Artist 2', 'duration': '3:50'},
    ],
    'Calm': [
      {'title': 'Calm Song 1', 'artist': 'Artist 3', 'duration': '5:20'},
      {'title': 'Calm Song 2', 'artist': 'Artist 4', 'duration': '4:10'},
    ],
    'Energetic': [
      {'title': 'Energetic Song 1', 'artist': 'Artist 5', 'duration': '3:40'},
      {'title': 'Energetic Song 2', 'artist': 'Artist 6', 'duration': '4:00'},
    ],
    'Happy': [
      {'title': 'Happy Song 1', 'artist': 'Artist 7', 'duration': '4:15'},
      {'title': 'Happy Song 2', 'artist': 'Artist 8', 'duration': '5:00'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getVerticalPadding = ScreenUtils.getImageSize(context, 8);

    List<Map<String, String>> filteredSongs = [];
    if (selectedMood == 'All') {
      for (var mood in displayMoods) {
        if (mood != 'All') {
          filteredSongs.addAll(songsByMood[mood] ?? []);
        }
      }
    } else {
      filteredSongs = songsByMood[selectedMood] ?? [];
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

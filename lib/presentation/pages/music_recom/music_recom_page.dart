import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/music/music.state.dart';
import 'package:moodify_mobile/presentation/bloc/music/music_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/music/music_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_state.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/list/recom_song.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicRecomPage extends StatefulWidget {
  const MusicRecomPage({Key? key}) : super(key: key);

  @override
  State<MusicRecomPage> createState() => _MusicRecomPageState();
}

class _MusicRecomPageState extends State<MusicRecomPage> {
  late MusicBloc _musicBloc;
  String selectedMood = 'All';
  late RecapBloc _recapBloc;

  @override
  void initState() {
    super.initState();
    _musicBloc = MusicBloc();
    _recapBloc = RecapBloc();
    _recapBloc.add(LoadRecapLatest());
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getVerticalPadding = ScreenUtils.getImageSize(context, 8);

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
          body: BlocListener<RecapBloc, RecapState>(
            bloc: _recapBloc,
            listener: (context, state) {
              if (state is RecapLoadedLatest) {
                setState(() {
                  state.moodDetected;
                });
                _musicBloc.add(FetchMusic(state.moodDetected.toLowerCase()));
              }
            },
            child: BlocBuilder<MusicBloc, MusicState>(
              bloc: _musicBloc,
              builder: (context, state) {
                if (state is MusicLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                } else if (state is MusicLoaded) {
                  List<Map<String, String>> filteredSongs;
                  if (selectedMood == 'All') {
                    filteredSongs = state.songs;
                    filteredSongs.shuffle();
                  } else {
                    filteredSongs = state.songs
                        .where((song) => song['mood'] == selectedMood)
                        .toList();
                    filteredSongs.shuffle();
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: getVerticalPadding,
                          ),
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
                                children: [
                                  ChoiceChip(
                                    showCheckmark: false,
                                    backgroundColor: Colors.white,
                                    selectedColor: const Color(0xFFA0D3F5)
                                        .withOpacity(0.6),
                                    side: BorderSide(
                                      color: const Color(0xFFA0D3F5)
                                          .withOpacity(0.6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: Text(
                                      'All',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: getFontSize * 0.9,
                                      ),
                                    ),
                                    selected: selectedMood == 'All',
                                    onSelected: (isSelected) {
                                      setState(() {
                                        if (isSelected) {
                                          selectedMood = 'All';
                                        }
                                      });
                                    },
                                  ),
                                  ...state.songs
                                      .map((song) => song['mood']!)
                                      .toSet()
                                      .map((mood) {
                                    return ChoiceChip(
                                      showCheckmark: false,
                                      backgroundColor: Colors.white,
                                      selectedColor: const Color(0xFFA0D3F5)
                                          .withOpacity(0.6),
                                      side: BorderSide(
                                        color: const Color(0xFFA0D3F5)
                                            .withOpacity(0.6),
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
                                          if (isSelected) {
                                            selectedMood = mood;
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (filteredSongs.isNotEmpty)
                          Column(
                            children: filteredSongs.map((song) {
                              return GestureDetector(
                                onTap: () async {
                                  final url = Uri.parse(song['url']!);
                                  print('Launching URL: $url');

                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    print('Could not launch $url');
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: ListSongRecom(
                                    total: 1,
                                    additionSizeImage: 1.4,
                                    additionSizeFont: 1.1,
                                    images: song['image']!,
                                    title: song['title']!,
                                    artist: song['artist']!,
                                    duration: song['duration']!,
                                  ),
                                ),
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
                  );
                } else if (state is MusicError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: getFontSize,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _musicBloc.close();
    super.dispose();
  }
}

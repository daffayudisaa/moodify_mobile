import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:moodify_mobile/presentation/bloc/music/music.state.dart';
import 'package:moodify_mobile/presentation/bloc/music/music_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/music/music_event.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_event.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_state.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_state.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/cards/mood_card.dart';
import 'package:moodify_mobile/presentation/widgets/list/recom_song.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String userMood;

  const HomePage({key, required this.userMood}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MusicBloc _musicBloc;
  String selectedMood = 'All';

  @override
  void initState() {
    super.initState();
    context.read<RecapBloc>().add(LoadRecap());
    _musicBloc = MusicBloc();
    _musicBloc.add(FetchMusic(widget.userMood));
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);
    double getImageSize = ScreenUtils.getImageSize(context, 50);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);

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
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.blue,
                      ));
                    } else if (state is ProfileLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello ${state.firstName},",
                                style: textStyle(
                                  getFontSize * 1.65,
                                  color: const Color(0xFF004373),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "How was your day?",
                                style: textStyle(
                                  getFontSize * 1.25,
                                  color: const Color(0xFF004373),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => navigateToPage(3),
                            child: CircleAvatar(
                              radius: getImageSize * 0.7,
                              backgroundImage: NetworkImage(
                                  'https://sirw.my.id/users/avatar/${state.avatar}'),
                            ),
                          ),
                        ],
                      );
                    } else if (state is ProfileError) {
                      print("Failed to load profile");
                    }
                    return Container(
                      color: Colors.pink,
                    ); // Placeholder in case no data is available
                  },
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => RecapBloc()..add(LoadRecapLatest()),
                  child: BlocBuilder<RecapBloc, RecapState>(
                    builder: (context, state) {
                      if (state is RecapLoading) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue));
                      } else if (state is RecapLoadedLatest) {
                        return Container(
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Feeling ${state.moodDetected}!",
                                      style: textStyle(
                                        getFontSize * 1.65,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Enjoy every moment!",
                                      style: textStyle(
                                        getFontSize * 1.1,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      formattedDate, // Display formatted date
                                      style: textStyle(
                                        getFontSize * 0.95,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image(
                                image: const AssetImage(
                                    'assets/meowdy/Meowdy-Happy.png'),
                                height: getImageSize * 2.3,
                              ),
                            ],
                          ),
                        );
                      } else if (state is RecapError) {
                        return Center(
                            child: Text('Error: ${state.errorMessage}'));
                      }

                      return const Center(child: Text('Unknown state'));
                    },
                  ),
                ),
                const SizedBox(height: 20),
                messageContainer(
                  "Happiness is when what you think, what you say, and what you do are in harmony.",
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
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
                ),
                const SizedBox(height: 5),
                BlocBuilder<MusicBloc, MusicState>(
                  bloc: _musicBloc,
                  builder: (context, state) {
                    if (state is MusicLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    } else if (state is MusicLoaded) {
                      List<Map<String, String>> filteredSongs;

                      if (selectedMood == 'All') {
                        filteredSongs = state.songs;
                      } else {
                        filteredSongs = state.songs
                            .where((song) => song['mood'] == selectedMood)
                            .toList();
                      }

                      filteredSongs.shuffle();
                      filteredSongs = filteredSongs.take(5).toList();

                      if (filteredSongs.isNotEmpty) {
                        return Column(
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
                                  additionSizeImage: 1.2,
                                  additionSizeFont: 1,
                                  images: song['image']!,
                                  title: song['title']!,
                                  artist: song['artist']!,
                                  duration: song['duration']!,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
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
                        );
                      }
                    }
                    return const SizedBox();
                  },
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
                  crossAxisSpacing:
                      MediaQuery.of(context).size.width > 1200 ? 12 : 8,
                  mainAxisSpacing:
                      MediaQuery.of(context).size.width > 1200 ? 15 : 10,
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 1200 ? 1.5 : 0.7,
                  children: [
                    BlocBuilder<RecapBloc, RecapState>(
                      builder: (context, state) {
                        if (state is RecapLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue));
                        } else if (state is RecapLoaded) {
                          return RecapMoodCard(
                            path: 'assets/meowdy/Meowdy-Happy.png',
                            mood: 'Happy',
                            count: state.happy,
                          );
                        } else if (state is RecapError) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<RecapBloc, RecapState>(
                      builder: (context, state) {
                        if (state is RecapLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue));
                        } else if (state is RecapLoaded) {
                          return RecapMoodCard(
                            path: 'assets/meowdy/Meowdy-Happy.png',
                            mood: 'Sad',
                            count: state.sad,
                          );
                        } else if (state is RecapError) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<RecapBloc, RecapState>(
                      builder: (context, state) {
                        if (state is RecapLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue));
                        } else if (state is RecapLoaded) {
                          return RecapMoodCard(
                            path: 'assets/meowdy/Meowdy-Happy.png',
                            mood: 'Angry',
                            count: state.angry,
                          );
                        } else if (state is RecapError) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<RecapBloc, RecapState>(
                      builder: (context, state) {
                        if (state is RecapLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue));
                        } else if (state is RecapLoaded) {
                          return RecapMoodCard(
                            path: 'assets/meowdy/Meowdy-Happy.png',
                            mood: 'Neutral',
                            count: state.neutral,
                          );
                        } else if (state is RecapError) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const SizedBox();
                      },
                    ),
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

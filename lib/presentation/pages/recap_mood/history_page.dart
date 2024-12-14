import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_state.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  MoodHistoryBloc? _moodHistoryBloc;
  List<Map<String, String>> _history = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _moodHistoryBloc = MoodHistoryBloc()
      ..add(FetchHistory(page: _currentPage, limit: _itemsPerPage));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to load more data when user scrolls to the bottom
  void _loadMoreData() {
    if (_moodHistoryBloc != null) {
      setState(() {
        _currentPage++;
      });
      _moodHistoryBloc!
          .add(FetchHistory(page: _currentPage, limit: _itemsPerPage));
    }
  }

  Widget _buildEmojiGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmojiItem('😡', 'Angry'),
            _buildEmojiItem('😢', 'Sad'),
            _buildEmojiItem('😐', 'Neutral')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmojiItem('😄', 'Happy'),
            _buildEmojiItem('😨', 'Fear'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmojiItem('🤮', 'Disgust'),
            _buildEmojiItem('😮', 'Surprise'),
          ],
        ),
      ],
    );
  }

  Widget _buildEmojiItem(String emoji, String label) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: getFontSize * 1.5),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: getFontSize * 1.1,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPercentageGrid(
    String angryScore,
    String fearScore,
    String surpriseScore,
    String sadScore,
    String happyScore,
    String disgustScore,
    String neutralScore,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPercentageItem('😡', angryScore),
            _buildPercentageItem('😨', fearScore),
            _buildPercentageItem('😮', surpriseScore),
            _buildPercentageItem('😐', neutralScore),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPercentageItem('😢', sadScore),
            _buildPercentageItem('😄', happyScore),
            _buildPercentageItem('🤮', disgustScore),
          ],
        ),
      ],
    );
  }

  Widget _buildPercentageItem(String emoji, String percentage) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Row(
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: getFontSize * 1.3),
        ),
        const SizedBox(width: 5),
        Text(
          percentage,
          style: TextStyle(
            fontSize: getFontSize * 1.1,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(List<Map<String, String>> history) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFA0D3F5).withOpacity(0.3),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: getFontSize * 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildEmojiGrid(),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, index) {
                var item = history[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFA0D3F5).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://sirw.my.id/images/${item['imageID']}',
                          width: screenWidth * 0.25,
                          height: screenHeight * 0.2,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      () {
                                        String formattedDate = '';
                                        if (item['CreatedAt'] != null) {
                                          try {
                                            DateTime parsedDate =
                                                DateTime.parse(
                                                    item['CreatedAt']!);
                                            formattedDate =
                                                DateFormat('yyyy-MM-dd HH:mm')
                                                    .format(parsedDate);
                                          } catch (e) {
                                            formattedDate =
                                                item['CreatedAt'] ?? '';
                                          }
                                        }
                                        return formattedDate;
                                      }(),
                                      style: TextStyle(
                                        fontSize: getFontSize,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Mood: ${item['AnalysisID'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: getFontSize * 1.2,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            _buildPercentageGrid(
                              item['AngryScore'] ?? '0',
                              item['FearScore'] ?? '0',
                              item['SurpriseScore'] ?? '0',
                              item['SadScore'] ?? '0',
                              item['HappyScore'] ?? '0',
                              item['DisgustScore'] ?? '0',
                              item['NeutralScore'] ?? '0',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_moodHistoryBloc != null &&
                history.isNotEmpty &&
                history.length % _itemsPerPage == 0)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _loadMoreData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(color: Colors.blue, width: 1),
                    ),
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowDown01,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (_) => _moodHistoryBloc!,
              child: BlocBuilder<MoodHistoryBloc, MoodHistoryState>(
                builder: (context, state) {
                  if (state is MoodHistoryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is MoodHistoryErrorState) {
                    return const Center(
                        child: Text("You haven't scanned your face yet"));
                  } else if (state is MoodHistoryLoadedState) {
                    _history.addAll(state.userHistory);
                    return _buildHistory(_history);
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

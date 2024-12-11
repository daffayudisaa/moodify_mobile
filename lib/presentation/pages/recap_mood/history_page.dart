import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_state.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isEmojiGridVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleEmojiGrid() {
    setState(() {
      _isEmojiGridVisible = !_isEmojiGridVisible;
    });
  }

  Widget _buildEmojiGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmojiItem('😡', 'Angry'),
            _buildEmojiItem('😢', 'Sad'),
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
            _buildEmojiItem('😞', 'Disgusting'),
            _buildEmojiItem('😮', 'Surprised'),
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
                  GestureDetector(
                    onTap: _toggleEmojiGrid,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          _isEmojiGridVisible
                              ? HugeIcons.strokeRoundedArrowDown01
                              : HugeIcons.strokeRoundedArrowUp01,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _isEmojiGridVisible,
                    child: _buildEmojiGrid(),
                  ),
                ],
              ),
            ),
            ...history.map((item) {
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
                      child: Image.network(
                        'https://sirw.my.id/images/${item['imageID']}',
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    () {
                                      String formattedDate = '';
                                      if (item['CreatedAt'] != null) {
                                        try {
                                          DateTime parsedDate = DateTime.parse(
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
            }).toList(),
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
      body: BlocProvider(
        create: (context) => MoodHistoryBloc()..add(FetchHistory()),
        child: BlocBuilder<MoodHistoryBloc, MoodHistoryState>(
          builder: (context, state) {
            if (state is MoodHistoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoodHistoryErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is MoodHistoryLoadedState) {
              return _buildHistory(state.userHistory);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

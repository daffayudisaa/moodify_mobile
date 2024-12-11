import 'package:flutter/material.dart';
import 'package:moodify_mobile/presentation/pages/recap_mood/history_page.dart';
import 'package:moodify_mobile/presentation/pages/recap_mood/recap_page.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class RecapMoodPage extends StatefulWidget {
  const RecapMoodPage({Key? key}) : super(key: key);

  @override
  State<RecapMoodPage> createState() => _MoodRecapState();
}

class _MoodRecapState extends State<RecapMoodPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEmojiGridVisible = true; // Control visibility for emoji grid

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleEmojiGrid() {
    setState(() {
      _isEmojiGridVisible = !_isEmojiGridVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);

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
                  'Recap Mood',
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
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  labelColor: const Color(0xFF004373),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color.fromRGBO(74, 144, 226, 0.5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashFactory: NoSplash.splashFactory,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Recap'),
                    Tab(text: 'History'),
                  ],
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: getFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: getFontSize,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RecapPage(),
                      HistoryPage(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

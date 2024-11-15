import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hugeicons/hugeicons.dart';

class RecapMoodPage extends StatefulWidget {
  const RecapMoodPage({Key? key}) : super(key: key);

  @override
  State<RecapMoodPage> createState() => _MoodRecapState();
}

class _MoodRecapState extends State<RecapMoodPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEmojiGridVisible = true; // Control visibility for emoji grid

  Map<String, double> dataMap = {
    "Sad": 14,
    "Happy": 15,
    "Disgusting": 32,
    "Surprised": 12,
    "Angry": 27,
  };
  List<Color> colorList = [
    const Color(0xffD0DFED),
    const Color(0xff9FD2F3),
    const Color(0xff478BD9),
    const Color(0xffF39F24),
    const Color(0xff265073),
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Recap Mood',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF004373),
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
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildRecap(),
                      _buildHistory(),
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

  Widget _buildRecap() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(160, 211, 245, 0.23),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Stats',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double chartSize = constraints.maxWidth / 2.5;
                          return PieChart(
                            dataMap: dataMap,
                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartLegendSpacing: 48,
                            chartRadius: chartSize,
                            colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 45,
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.left,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                              decimalPlaces: 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 80.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(75, 158, 158, 158)),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedMenu08,
                        color: Colors.black,
                        size: 10.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
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
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
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
                  color: Colors.blue.withOpacity(0.3),
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
                              ? HugeIcons
                                  .strokeRoundedArrowDown01 // Tanda panah kebawah
                              : HugeIcons
                                  .strokeRoundedArrowUp01, // Tanda panah keatas
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
            Column(
              children: List.generate(10, (index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/User.jpg',
                          width: 90,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Dec, 11 2024',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Mood: Happy',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            _buildPercentageGrid(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 23),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPercentageGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPercentageItem('😡', '7%'),
            _buildPercentageItem('😨', '10%'),
            _buildPercentageItem('😮', '25%'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPercentageItem('😢', '35%'),
            _buildPercentageItem('😄', '50%'),
            _buildPercentageItem('😞', '15%'),
          ],
        )
      ],
    );
  }

  Widget _buildPercentageItem(String emoji, String percentage) {
    return Row(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 5),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
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

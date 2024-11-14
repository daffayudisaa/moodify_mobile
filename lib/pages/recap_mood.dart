import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hugeicons/hugeicons.dart';

class RecapMoodPage extends StatefulWidget {
  const RecapMoodPage({Key? key}) : super(key: key);

  @override
  State<RecapMoodPage> createState() => _MoodRecapState();
}

class _MoodRecapState extends State<RecapMoodPage> {
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Mood Recap'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom tab bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Column(
                      children: [
                        Text(
                          'Recap',
                          style: TextStyle(
                            fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedIndex == 0 ? Colors.blue : Colors.black,
                          ),
                        ),
                        if (_selectedIndex == 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            height: 2.0,
                            width: 50,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: Column(
                      children: [
                        Text(
                          'History',
                          style: TextStyle(
                            fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedIndex == 1 ? Colors.blue : Colors.black,
                          ),
                        ),
                        if (_selectedIndex == 1)
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            height: 2.0,
                            width: 50,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Show the description text only in the Recap tab
              if (_selectedIndex == 0)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  height: 100,
                  width: double.infinity,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Allows users to track and reflect on their emotional states over time.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 1),
              // Show the appropriate content based on the selected tab
              if (_selectedIndex == 0) _buildRecap(),
              if (_selectedIndex == 1) _buildHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecap() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(160, 211, 245, 0.23),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
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
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 48,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 48,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.left,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: true,
                        decimalPlaces: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 80.0,
                  transformAlignment: Alignment.centerRight,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing before the boxes
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 5,
              childAspectRatio: 0.7,
              children: const [
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Happy',
                  count: 3,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Sad',
                  count: 2,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Surprised',
                  count: 1,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Angry',
                  count: 1,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Happy',
                  count: 3,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Sad',
                  count: 2,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Surprised',
                  count: 1,
                ),
                RecapMoodCard(
                  path: 'assets/meowdy/Meowdy-Happy.png',
                  mood: 'Angry',
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
      child: Text(
        'History View',
        style: TextStyle(fontSize: 24),
      ),
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
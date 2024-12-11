import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/presentation/widgets/cards/mood_card.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:pie_chart/pie_chart.dart';

class RecapPage extends StatefulWidget {
  const RecapPage({Key? key}) : super(key: key);

  @override
  State<RecapPage> createState() => _RecapPageState();
}

class _RecapPageState extends State<RecapPage> {
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                height: screenHeight * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(160, 211, 245, 0.3),
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
                      Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Stats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getFontSize * 1.3,
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
                              chartLegendSpacing: screenWidth * 0.1,
                              chartRadius: chartSize,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 45,
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: getFontSize),
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
                crossAxisSpacing:
                    MediaQuery.of(context).size.width > 1200 ? 12 : 8,
                mainAxisSpacing:
                    MediaQuery.of(context).size.width > 1200 ? 15 : 10,
                childAspectRatio:
                    MediaQuery.of(context).size.width > 1200 ? 1.5 : 0.7,
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
      ),
    );
  }
}

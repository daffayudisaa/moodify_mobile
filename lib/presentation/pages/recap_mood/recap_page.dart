import 'package:flutter/material.dart';
import 'package:moodify_mobile/presentation/widgets/cards/mood_card.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_state.dart';

class RecapPage extends StatefulWidget {
  const RecapPage({Key? key}) : super(key: key);

  @override
  State<RecapPage> createState() => _RecapPageState();
}

class _RecapPageState extends State<RecapPage> {
  Map<String, double> dataMap = {};
  List<Color> colorList = [
    const Color(0xffD0DFED),
    const Color(0xff9FD2F3),
    const Color(0xff478BD9),
    const Color(0xff265073),
    const Color.fromARGB(255, 207, 128, 10),
    const Color(0xFFFF9D0B),
    const Color(0xFFFBBD39),
  ];

  @override
  void initState() {
    super.initState();
    // Trigger LoadRecap event to load mood data
    context.read<RecapBloc>().add(LoadRecap());
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15),
                height: screenHeight * 0.4,
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
                            double chartSize = constraints.maxWidth * 0.6;
                            return BlocBuilder<RecapBloc, RecapState>(
                              builder: (context, state) {
                                if (state is RecapLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.blue));
                                } else if (state is RecapLoaded) {
                                  dataMap = {
                                    "Happy": state.happy.toDouble(),
                                    "Sad": state.sad.toDouble(),
                                    "Disgust": state.disgust.toDouble(),
                                    "Surprise": state.surprise.toDouble(),
                                    "Fear": state.fear.toDouble(),
                                    "Angry": state.angry.toDouble(),
                                    "Neutral": state.neutral.toDouble(),
                                  };
                                  return PieChart(
                                    dataMap: dataMap,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: screenWidth * 0.12,
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
                                          fontSize: getFontSize * 0.95),
                                    ),
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: true,
                                      showChartValuesOutside: true,
                                      decimalPlaces: 0,
                                    ),
                                  );
                                } else if (state is RecapError) {
                                  return Center(
                                      child: Text(state.errorMessage));
                                }
                                return Container();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Loading spinner will only be shown once here
              BlocBuilder<RecapBloc, RecapState>(
                builder: (context, state) {
                  if (state is RecapLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.blue));
                  }
                  return GridView.count(
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
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Happy.png',
                        mood: 'Happy',
                        count: state is RecapLoaded ? state.happy : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Sad.png',
                        mood: 'Sad',
                        count: state is RecapLoaded ? state.sad : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Angry.png',
                        mood: 'Angry',
                        count: state is RecapLoaded ? state.angry : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Surprise.png',
                        mood: 'Surprise',
                        count: state is RecapLoaded ? state.surprise : 0,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),
              BlocBuilder<RecapBloc, RecapState>(
                builder: (context, state) {
                  if (state is RecapLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.blue));
                  }
                  return GridView.count(
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
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Disgust.png',
                        mood: 'Disgust',
                        count: state is RecapLoaded ? state.disgust : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Fear.png',
                        mood: 'Fear',
                        count: state is RecapLoaded ? state.fear : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Neutral.png',
                        mood: 'Neutral',
                        count: state is RecapLoaded ? state.neutral : 0,
                      ),
                      RecapMoodCard(
                        path: 'assets/meowdy/Meowdy-Total.png',
                        mood: 'Total',
                        count: state is RecapLoaded ? state.total : 0,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

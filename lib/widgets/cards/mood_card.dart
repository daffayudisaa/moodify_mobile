import 'package:flutter/material.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.7;

    double titleFontSize = 14 * multiplier;
    double imageSize = 18 * multiplier;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFA0D3F5).withOpacity(0.65),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(path),
            height: imageSize * 3,
          ),
          Text(
            mood,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: titleFontSize * 0.85,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: titleFontSize * 0.85,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

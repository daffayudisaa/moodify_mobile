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
    final screenHeight = MediaQuery.of(context).size.height;

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
            height: screenHeight * 0.06,
            width: 60,
          ),
          Text(
            mood,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: screenHeight * 0.015,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: screenHeight * 0.013,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

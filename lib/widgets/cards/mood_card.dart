import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

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
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getImageSize = ScreenUtils.getImageSize(context, 18);

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
            height: getImageSize * 3.25,
          ),
          Text(
            mood,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: getFontSize * 0.9,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: getFontSize * 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

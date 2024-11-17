import 'package:flutter/material.dart';

class ListSongRecom extends StatelessWidget {
  final int? total;
  final String images;
  final String title;
  final String artist;
  final String duration;

  const ListSongRecom({
    this.total = 5,
    required this.images,
    required this.title,
    required this.artist,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double imageSize = 50 * multiplier;
    double titleFontSize = 14 * multiplier;
    double artistFontSize = 12 * multiplier;
    double durationFontSize = 13 * multiplier;
    double horizontalPadding = 30 * multiplier;
    double verticalPadding = 8 * multiplier;
    double spacing = 10 * multiplier;

    return Column(
      children: List.generate(
        total!,
        (index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Row(
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8 * multiplier),
                  ),
                ),
                SizedBox(width: spacing),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: titleFontSize,
                            ),
                          ),
                          Text(
                            artist,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: artistFontSize,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spacing),
                        child: Text(
                          duration,
                          style: TextStyle(
                            fontSize: durationFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

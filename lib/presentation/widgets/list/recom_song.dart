import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class ListSongRecom extends StatelessWidget {
  final int? total;
  final double? additionSizeImage;
  final double? additionSizeFont;
  final String images;
  final String title;
  final String artist;
  final String duration;

  const ListSongRecom({
    this.total = 5,
    this.additionSizeImage = 1,
    this.additionSizeFont = 1,
    required this.images,
    required this.title,
    required this.artist,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double multiplier = ScreenUtils.getMultiplier(context);

    double imageSize = 45 * multiplier;
    double titleFontSize = 13 * multiplier;
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
                  width: imageSize * additionSizeImage!,
                  height: imageSize * additionSizeImage!,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(images),
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
                            title.length > 20
                                ? '${title.substring(0, 10)}...'
                                : title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: titleFontSize * additionSizeFont!,
                            ),
                          ),
                          Text(
                            artist.length > 20
                                ? '${artist.substring(0, 20)}...'
                                : artist,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: artistFontSize * additionSizeFont!,
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
                            fontFamily: 'Poppins',
                            fontSize: durationFontSize * additionSizeFont!,
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

import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class FillButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final Color? textColor;
  final String text;

  const FillButton({
    required this.onTap,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: getFontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FillButtonRoute extends StatelessWidget {
  final String route;
  final Color color;
  final Color? textColor;
  final String text;
  final int? index;

  const FillButtonRoute({
    required this.route,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
    this.index = 0,
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

    double fontSize = 13 * multiplier;
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
          context,
          route,
          (Route<dynamic> route) => false,
          arguments: index,
        );
      },
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
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class FillButtonPage extends StatelessWidget {
  final Widget route;
  final Color color;
  final Color? textColor;
  final String text;

  const FillButtonPage({
    required this.route,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
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

    double fontSize = 13 * multiplier;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
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
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}

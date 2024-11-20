import 'package:flutter/material.dart';

class DropdownDynammic extends StatefulWidget {
  final String text;
  final List<String> items;

  const DropdownDynammic({super.key, required this.items, required this.text});

  @override
  State<DropdownDynammic> createState() => _DropdownDynammicState();
}

class _DropdownDynammicState extends State<DropdownDynammic> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double fontSize = 13 * multiplier;

    return DropdownButtonFormField<String>(
      value: selectedValue,
      dropdownColor: Colors.white,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFA0D3F5).withOpacity(0.2),
        hintText: widget.text,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize * 0.9,
          color: Colors.black54,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xFF008EF2),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
      ),
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize * 0.9,
            color: Colors.black54,
          ),
        ),
      ),
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fontSize,
              color: Colors.black87,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}

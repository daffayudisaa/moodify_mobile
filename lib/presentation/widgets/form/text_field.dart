import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? isEditing;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: isEditing ?? false,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: getFontSize * 1.1,
        color: isEditing == true ? Colors.grey.shade600 : Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: getFontSize * 0.9,
          color: Colors.black54,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        filled: true,
        fillColor: const Color(0xFFA0D3F5).withOpacity(0.2),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: isEditing == true
                ? Colors.transparent
                : const Color(0xFF008EF2),
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
    );
  }
}

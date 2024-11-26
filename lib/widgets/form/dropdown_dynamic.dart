import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class DropdownDynamic extends StatefulWidget {
  final String text;
  final List<String> items;
  final String? initialValue; // Menambahkan parameter untuk nilai awal

  const DropdownDynamic({
    super.key,
    required this.items,
    required this.text,
    this.initialValue, // Inisialisasi nilai awal opsional
  });

  @override
  State<DropdownDynamic> createState() => _DropdownDynamicState();
}

class _DropdownDynamicState extends State<DropdownDynamic> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue; // Mengatur nilai awal
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);

    return DropdownButtonFormField<String>(
      value: selectedValue, // Menampilkan nilai awal jika ada
      dropdownColor: Colors.white,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFA0D3F5).withOpacity(0.2),
        hintText: widget.text,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: getFontSize * 0.9,
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
            fontSize: getFontSize * 0.9,
            fontWeight: FontWeight.w500,
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
              fontWeight: FontWeight.w400,
              fontSize: getFontSize * 1.1,
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

import 'package:flutter/material.dart';

class DateOfBirthInput extends StatefulWidget {
  const DateOfBirthInput({super.key});

  @override
  _DateOfBirthInputState createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<DateOfBirthInput> {
  TextEditingController dateController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(
                primary: Colors.blue, secondary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DateCustomField(
            hintText: 'Birth Date',
            controller: dateController,
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
        ),
      ],
    );
  }
}

class DateCustomField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback onTap;

  const DateCustomField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
    this.readOnly = false,
    required this.onTap,
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

    return Stack(
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fontSize * 0.9,
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
        ),
        Positioned(
          right: 10,
          top: 2,
          child: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.black54),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';

class DateOfBirthInput extends StatefulWidget {
  final TextEditingController? controller;
  final bool? enabled;

  const DateOfBirthInput({Key? key, this.controller, this.enabled})
      : super(key: key);

  @override
  _DateOfBirthInputState createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<DateOfBirthInput> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _dateController.dispose();
    }
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    if (widget.enabled != false) {
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
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
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
          _dateController.text =
              "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DateCustomField(
            hintText: 'Birth Date',
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            readOnly: widget.enabled == false,
            onTap: () => _selectDate(context),
            enabled: widget.enabled,
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
  final bool? enabled;

  const DateCustomField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
    this.readOnly = false,
    required this.onTap,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);

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
            fontSize: getFontSize * 1.1,
            color: enabled == false ? Colors.grey.shade600 : Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: getFontSize * 0.9,
              color: enabled == false ? Colors.grey.shade600 : Colors.black54,
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
                color: enabled == false
                    ? Colors.transparent
                    : const Color(0xFF008EF2),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color:
                    enabled == false ? Colors.transparent : Colors.transparent,
                width: 1,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 2,
          child: IconButton(
            icon: Icon(Icons.calendar_today,
                color: enabled == false ? Colors.grey : Colors.black54),
            onPressed: enabled == false ? null : onTap,
          ),
        ),
      ],
    );
  }
}

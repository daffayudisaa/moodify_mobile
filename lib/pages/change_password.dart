import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double titleFontSize = 14 * multiplier;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: titleFontSize * 1.7,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF004373)),
        ),
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft02,
              color: Color(0xFF004373),
              size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                hintText: 'Curent Password',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
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
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                hintText: 'New Password',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
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
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
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
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: FillButtonRoute(
                    route: '/navbar',
                    index: 3,
                    color: Color(0xFFFF5855),
                    text: 'Cancel',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: FillButtonRoute(
                    route: '/navbar',
                    index: 0,
                    color: Color(0xFF42B1FF),
                    text: 'Save',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

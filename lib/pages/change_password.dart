import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
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
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: getFontSize * 1.7,
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
            Row(
              children: [
                Expanded(
                  child: FillButton(
                    color: const Color(0xFFFF5855),
                    text: 'Cancel',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/navbar',
                        (Route<dynamic> route) => false,
                        arguments: 3,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: FillButton(
                    color: const Color(0xFF42B1FF),
                    text: 'Save',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/navbar',
                        (Route<dynamic> route) => false,
                        arguments: 3,
                      );
                    },
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

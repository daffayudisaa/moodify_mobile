import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

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
    double fontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(fontSize),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              obscureText: true,
              controller: _currentPasswordController,
              hintText: 'Current Password',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              obscureText: true,
              controller: _newPasswordController,
              hintText: 'New Password',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              obscureText: true,
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
            ),
            const SizedBox(height: 40),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(double fontSize) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      title: Text(
        "Change Password",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize * 1.7,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF004373),
        ),
      ),
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedArrowLeft02,
          color: Color(0xFF004373),
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
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
    );
  }
}

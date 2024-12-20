import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA0D3F5),
                Color(0xFFD9E9F8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft02,
                    color: Color(0xFF004373),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/meowdy/Meowdy-Drink.png'),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'New Password',
                                    style: TextStyle(
                                      color: const Color(0xFF263238),
                                      fontFamily: 'Poppins',
                                      fontSize: getFontSize * 2.5,
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Set a new password and get back to enjoying Moodify.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: getFontSize * 0.9,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 40,
                                left: 40,
                                top: 30,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Time to set a new password! Make it strong, unique, and something you’ll remember!',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: getFontSize * 0.9,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),
                                    const CustomTextField(
                                        hintText: 'New Password',
                                        obscureText: true),
                                    const SizedBox(height: 20),
                                    const CustomTextField(
                                        hintText: 'Confirm New Password',
                                        obscureText: true),
                                    const SizedBox(height: 40),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FillButton(
                                            color: Color(0xFF42B1FF),
                                            text: 'Save',
                                            onTap: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/signin',
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

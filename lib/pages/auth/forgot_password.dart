import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/pages/auth/reset_password.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
      body: Container(
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
              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
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
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: const Color(0xFF263238),
                                    fontFamily: 'Poppins',
                                    fontSize: titleFontSize * 2.5,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'No worries, let’s help you get back on track!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: titleFontSize * 0.95,
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'To reset your password, please enter your email, click the button below, and check yor inbox for further instructions.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: titleFontSize * 0.9,
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        const CustomTextField(
                                            hintText: 'Email Address'),
                                        const SizedBox(height: 40),
                                        const FillButtonPage(
                                          route: ResetPasswordPage(),
                                          color: Color(0xFF42B1FF),
                                          text: 'Send Verification Link',
                                        ),
                                        const SizedBox(height: 40),
                                      ],
                                    ),
                                  ),
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
    );
  }
}

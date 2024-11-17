import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/pages/auth/reset_password.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/meowdy/Meowdy-Drink.png'),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: Color(0xFF263238),
                                    fontFamily: 'Poppins',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'No worries, let’s help you get back on track!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
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
                          child: const Padding(
                            padding: EdgeInsets.only(
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
                                            fontSize: 14,
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20),
                                        CustomTextField(
                                            hintText: 'Email Address'),
                                        SizedBox(height: 40),
                                        FillButtonPage(
                                          route: ResetPasswordPage(),
                                          color: Color(0xFF42B1FF),
                                          text: 'Send Verification Link',
                                        ),
                                        SizedBox(height: 40),
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

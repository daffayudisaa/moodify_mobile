import 'package:flutter/material.dart';
import 'package:moodify_mobile/pages/auth/forgot_password.dart';
import 'package:moodify_mobile/pages/auth/sign_up.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topContainerHeight = screenHeight * 0.35;
    final imageHeight = topContainerHeight * 0.45;
    double screenWidth = MediaQuery.of(context).size.width;
    double getFontSize = ScreenUtils.getFontSize(context, 13);

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Column(
            children: [
              Container(
                height: topContainerHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA0D3F5),
                      Color(0xFFD9E9F8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 30,
                          bottom: imageHeight,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Welcome to Moodify",
                                style: TextStyle(
                                  color: Color(0xFF263238),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  height: 0.9,
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              "Feel it. Hear it. Live it.",
                              style: TextStyle(
                                color: Color(0xFF263238),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                height: 0.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 25,
                        child: Image(
                          image: const AssetImage(
                            'assets/meowdy/Meowdy-Calm.png',
                          ),
                          height: imageHeight,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: screenHeight * 0.65,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(23, 23, 23, 0.15),
                      spreadRadius: 0,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomTextField(hintText: 'Email'),
                    const SizedBox(height: 25),
                    const CustomTextField(
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: const Color(0xFF0096FF),
                              fontSize: getFontSize * 0.8,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: FillButton(
                            color: const Color(0xFF42B1FF),
                            text: 'Sign In',
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/navbar',
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Or Continue With",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          fontFamily: 'Poppins',
                          fontSize: getFontSize * 0.85,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(context, '/navbar',
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Color.fromRGBO(38, 50, 56, 0.4),
                              width: 0.3,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: 18,
                              width: 18,
                              image:
                                  AssetImage('assets/images/Google-Logo.png'),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Google",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: getFontSize,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.6),
                              fontFamily: 'Poppins',
                              fontSize: getFontSize * 0.85,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Register",
                                style: TextStyle(
                                  color: const Color(0xFF0096FF),
                                  fontSize: getFontSize * 0.85,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

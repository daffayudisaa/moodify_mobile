import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 60,
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
          flexibleSpace: Container(
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
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              right: 40,
              left: 40,
              top: 20,
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
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Text(
                  "Create an Account",
                  style: TextStyle(
                    color: const Color(0xFF004373),
                    fontSize: titleFontSize * 1.6,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Unlock a world where your feelings guide the sound.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF004373),
                      fontSize: titleFontSize * 0.95,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const CustomTextField(hintText: 'Email'),
                const SizedBox(height: 20),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(hintText: 'First Name'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(hintText: 'Last Name'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const CustomTextField(hintText: 'Gender'),
                const SizedBox(height: 20),
                const CustomTextField(hintText: 'Birth Date'),
                const SizedBox(height: 20),
                const CustomTextField(hintText: 'Passwrod', obscureText: true),
                const SizedBox(height: 20),
                const CustomTextField(
                    hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Expanded(
                      child: FillButtonRoute(
                        route: '/signin',
                        color: Color(0xFF42B1FF),
                        text: 'Create Account',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          fontFamily: 'Poppins',
                          fontSize: titleFontSize * 0.85,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamedAndRemoveUntil(context, '/signin',
                            (Route<dynamic> route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              color: const Color(0xFF0096FF),
                              fontSize: titleFontSize * 0.85,
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
        ));
  }
}

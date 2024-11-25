import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';
import 'package:moodify_mobile/widgets/form/dateofbirth_picker.dart';
import 'package:moodify_mobile/widgets/form/dropdown_dynamic.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 13);

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
                    fontSize: getFontSize * 1.6,
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
                      fontSize: getFontSize * 0.95,
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
                const DropdownDynamic(
                    items: ['Male', 'Female'], text: 'Gender'),
                const SizedBox(height: 20),
                const DateOfBirthInput(),
                const SizedBox(height: 20),
                const CustomTextField(hintText: 'Password', obscureText: true),
                const SizedBox(height: 20),
                const CustomTextField(
                    hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FillButton(
                        color: Color(0xFF42B1FF),
                        text: 'Create Account',
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          fontFamily: 'Poppins',
                          fontSize: getFontSize * 0.85,
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
        ));
  }
}

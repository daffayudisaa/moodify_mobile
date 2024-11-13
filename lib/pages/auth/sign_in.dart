import 'package:flutter/material.dart';
import 'package:moodify_mobile/pages/auth/forgot_password.dart';
import 'package:moodify_mobile/pages/auth/sign_up.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA0D3F5),
                    Color(0xFFD9E9F8),
                  ],
                ),
              ),
              child: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to Moodify",
                        style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            height: 0.9),
                      ),
                      SizedBox(height: 13),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Feel it. Hear it. Live it.",
                          style: TextStyle(
                              color: Color(0xFF263238),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              height: 0.9),
                        ),
                      ),
                      SizedBox(height: 1),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image(
                          image: AssetImage(
                            'assets/meowdy/Meowdy-Calm.png',
                          ),
                          height: 135,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
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
              height: 500,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
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
                  const SizedBox(height: 25),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Color(0xFF0096FF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/navbar', (Route<dynamic> route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0096FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 126, vertical: 15),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Or Continue With",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/navbar', (Route<dynamic> route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(
                          color: Color.fromRGBO(
                              38, 50, 56, 0.4), // Warna border (stroke)
                          width: 0.3, // Ketebalan border
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110, vertical: 15),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            height: 18,
                            width: 18,
                            image: AssetImage('assets/images/Google-Logo.png')),
                        SizedBox(width: 10),
                        Text(
                          "Google",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontFamily: 'Poppins',
                            fontSize: 12,
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                color: Color(0xFF0096FF),
                                fontSize: 12,
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
    );
  }
}

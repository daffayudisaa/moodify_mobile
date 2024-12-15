import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/pages/auth/sign_up.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_state.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';
import 'package:moodify_mobile/presentation/pages/auth/forgot_password.dart';
//import 'package:moodify_mobile/presentation/widgets/buttons/button_spotify.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topContainerHeight = screenHeight * 0.35;
    final imageHeight = topContainerHeight * 0.45;
    double screenWidth = MediaQuery.of(context).size.width;
    double getFontSize = ScreenUtils.getFontSize(context, 13);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              },
            );
          } else if (state is AuthAuthenticated) {
            // Navigate to navbar on successful login
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/navbar',
              (route) => false,
            );
          } else if (state is AuthError) {
            // Show error message
            Navigator.pop(context); // Remove loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
              ),
            );
          }
        },
        child: SingleChildScrollView(
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
                      CustomTextField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 25),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: !isPasswordVisible,
                            controller: passwordController,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0), // Geser ikon ke kiri
                            child: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
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
                                // Trigger AuthBloc login event
                                BlocProvider.of<AuthBloc>(context).add(
                                  SignInRequested(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Text(
                      //   "Or Continue With",
                      //   style: TextStyle(
                      //     color: const Color.fromRGBO(0, 0, 0, 0.6),
                      //     fontFamily: 'Poppins',
                      //     fontSize: getFontSize * 0.85,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // const SizedBox(height: 15),
                      // button_spotify(getFontSize: getFontSize),
                      // const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.6),
                              fontFamily: 'Poppins',
                              fontSize: getFontSize * 0.85,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
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
      ),
    );
  }
}

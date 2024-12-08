import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_state.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/dateofbirth_picker.dart';
import 'package:moodify_mobile/presentation/widgets/form/dropdown_dynamic.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? gender;
  DateTime? birthdate;

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/signin',
              (Route<dynamic> route) => false,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Your account has been successfully created!"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AuthError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
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
                CustomTextField(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              controller: firstNameController,
                              hintText: 'First Name'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                              controller: lastNameController,
                              hintText: 'Last Name'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownDynamic(
                  items: const ['Male', 'Female'],
                  text: 'Gender',
                  initialValue: gender,
                  enabled: true,
                  onChanged: (value) {
                    gender = value;
                  },
                ),
                const SizedBox(height: 20),
                DateOfBirthInput(
                  onDateChanged: (date) {
                    setState(() {
                      birthdate = date;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FillButton(
                        color: Color(0xFF42B1FF),
                        text: 'Create Account',
                        onTap: () {
                          // Validation: Check if any required field is empty
                          if (emailController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty ||
                              gender == null ||
                              birthdate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill all fields")),
                            );
                          } else if (passwordController.text.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Password must be at least 8 characters")),
                            );
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Passwords do not match")),
                            );
                          } else {
                            BlocProvider.of<AuthBloc>(context).add(
                              SignUpRequested(
                                emailController.text,
                                passwordController.text,
                                firstNameController.text,
                                lastNameController.text,
                                gender ?? '',
                                birthdate?.toIso8601String() ??
                                    DateTime.now().toIso8601String(),
                              ),
                            );
                          }
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
        ),
      ),
    );
  }
}

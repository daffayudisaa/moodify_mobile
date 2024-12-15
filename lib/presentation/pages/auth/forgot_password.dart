import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendVerificationLink(String email) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://sirw.my.id/forgot_password/$email'),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A new password has been sent to your email.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 40, left: 20, right: 20),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/signin',
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              responseData['message'] ?? 'Failed to send verification link.',
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                                        fontSize: getFontSize * 2.5,
                                        fontWeight: FontWeight.w600,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "No worries, let’s help you get back on track!",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: getFontSize * 0.95,
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
                                            'To reset your password, please enter your email, click the button below, and check your inbox for further instructions.',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: getFontSize * 0.9,
                                              height: 1.2,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            hintText: 'Email Address',
                                            controller: _emailController,
                                          ),
                                          const SizedBox(height: 40),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: FillButton(
                                                  color:
                                                      const Color(0xFF42B1FF),
                                                  text:
                                                      'Send Verification Link',
                                                  onTap: () {
                                                    final email =
                                                        _emailController.text
                                                            .trim();
                                                    if (email.isNotEmpty) {
                                                      _sendVerificationLink(
                                                          email);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Please enter a valid email.'),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 40,
                                                                  left: 20,
                                                                  right: 20),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Opacity(
              opacity: 0.6,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black,
              ),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}

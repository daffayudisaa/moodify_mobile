import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_event.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fontSize = ScreenUtils.getFontSize(context, 14);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize * 1.7,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004373),
          ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            color: Color(0xFF004373),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/navbar',
              (Route<dynamic> route) => false,
              arguments: 3,
            );
          },
        ),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              },
            );

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password successfully changed'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating, 
                  margin: EdgeInsets.only( bottom: 40, left: 20, right: 20),
                ),
              );

              _clearTextFields();
            });
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), 
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating, 
              margin: const EdgeInsets.only( bottom: 40, left: 20, right: 20),),
              
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                obscureText: true,
                controller: _currentPasswordController,
                hintText: 'Current Password',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: true,
                controller: _newPasswordController,
                hintText: 'New Password',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: FillButton(
                      color: const Color(0xFFFF5855),
                      text: 'Cancel',
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/navbar',
                          (Route<dynamic> route) => false,
                          arguments: 3,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: FillButton(
                      color: const Color(0xFF42B1FF),
                      text: 'Save',
                      onTap: () {
                        if (_newPasswordController.text ==
                            _confirmPasswordController.text) {
                          BlocProvider.of<ChangePasswordBloc>(context).add(
                            ChangePasswordSubmitted(
                              oldPassword: _currentPasswordController.text,
                              newPassword: _newPasswordController.text,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords do not match')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearTextFields() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }
}

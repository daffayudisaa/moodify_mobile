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
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmNewPasswordVisible = false;

  bool _hasChanges = false;

  void _onTextChanged() {
    setState(() {
      _hasChanges = _currentPasswordController.text.isNotEmpty ||
          _newPasswordController.text.isNotEmpty ||
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  Future<void> _showCancelDialog(BuildContext context) async {
    if (!_hasChanges) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/navbar',
        (Route<dynamic> route) => false,
        arguments: 3,
      );
      return;
    }

    final bool? shouldCancel = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/Danger.jpg',
                height: 70,
                width: 70,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15),
              Text(
                'Discard Changes?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: ScreenUtils.getFontSize(context, 14) * 1.5,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              'Are you sure you want to discard the changes?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ScreenUtils.getFontSize(context, 14) * 0.9,
              ),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 30),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: ScreenUtils.getFontSize(context, 14) * 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF5350),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: ScreenUtils.getFontSize(context, 14) * 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (shouldCancel ?? false) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/navbar',
        (Route<dynamic> route) => false,
        arguments: 3,
      );
    }
  }

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
          onPressed: () => _showCancelDialog(context),
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
                  margin: EdgeInsets.only(bottom: 40, left: 20, right: 20),
                ),
              );

              _clearTextFields();
            });
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextField(
                    hintText: 'Current Password',
                    obscureText: !isCurrentPasswordVisible,
                    controller: _currentPasswordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0), // Geser ikon ke kiri
                    child: IconButton(
                      icon: Icon(
                        isCurrentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isCurrentPasswordVisible = !isCurrentPasswordVisible;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextField(
                    hintText: 'New Password',
                    obscureText: !isNewPasswordVisible,
                    controller: _newPasswordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0), // Geser ikon ke kiri
                    child: IconButton(
                      icon: Icon(
                        isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextField(
                    hintText: 'Confirm New Password',
                    obscureText: !isConfirmNewPasswordVisible,
                    controller: _confirmPasswordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0), // Geser ikon ke kiri
                    child: IconButton(
                      icon: Icon(
                        isConfirmNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmNewPasswordVisible =
                              !isConfirmNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: FillButton(
                      color: const Color(0xFFFF5855),
                      text: 'Cancel',
                      onTap: () => _showCancelDialog(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: FillButton(
                      color: const Color(0xFF42B1FF),
                      text: 'Save',
                      onTap: () {
                        final oldPassword = _currentPasswordController.text;
                        final newPassword = _newPasswordController.text;
                        final confirmPassword = _confirmPasswordController.text;

                        if (newPassword == confirmPassword) {
                          if (oldPassword != newPassword) {
                            BlocProvider.of<ChangePasswordBloc>(context).add(
                              ChangePasswordSubmitted(
                                oldPassword: oldPassword,
                                newPassword: newPassword,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'New password cannot be the same as the old password'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, left: 20, right: 20),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                  bottom: 40, left: 20, right: 20),
                            ),
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

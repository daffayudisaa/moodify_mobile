import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moodify_mobile/bloc/profile/profile_bloc.dart';
import 'package:moodify_mobile/bloc/profile/profile_state.dart';
import 'package:moodify_mobile/pages/change_password.dart';
import 'package:moodify_mobile/widgets/form/dateofbirth_picker.dart';
import 'package:moodify_mobile/widgets/form/dropdown_dynamic.dart';
import 'package:moodify_mobile/widgets/form/text_field.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';

import '../bloc/profile/profile_event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double multiplier = screenWidth < 600
        ? 1.0
        : screenWidth < 1200
            ? 1.2
            : 1.4;

    double titleFontSize = 14 * multiplier;

    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                toolbarHeight: 80,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: titleFontSize * 1.7,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF004373),
                    ),
                  ),
                ),
              ),
            ],
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadedState) {
                  String birthDateString =
                      DateFormat('dd-MM-yyyy').format(state.birthDate);

                  final firstNameController =
                      TextEditingController(text: state.firstName);
                  final lastNameController =
                      TextEditingController(text: state.lastName);
                  final emailController =
                      TextEditingController(text: state.email);
                  final genderController =
                      TextEditingController(text: state.gender);
                  final birthDateController =
                      TextEditingController(text: birthDateString);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage('assets/images/User.jpg'),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First Name",
                                      style: TextStyle(
                                        fontSize: titleFontSize * 0.9,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    CustomTextField(
                                        hintText: 'First Name',
                                        controller: firstNameController),
                                    const SizedBox(height: 13),
                                    Text(
                                      "Last Name",
                                      style: TextStyle(
                                        fontSize: titleFontSize * 0.9,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    CustomTextField(
                                        hintText: 'Last Name',
                                        controller: lastNameController),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: titleFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomTextField(
                              hintText: 'Email', controller: emailController),
                          const SizedBox(height: 7),
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: titleFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DropdownDynamic(
                              initialValue: genderController.text,
                              items: const ['Male', 'Female', 'Privacy'],
                              text: 'Gender'),
                          const SizedBox(height: 7),
                          Text(
                            "Birth Date",
                            style: TextStyle(
                              fontSize: titleFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DateOfBirthInput(controller: birthDateController),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/navbar',
                                  index: 3,
                                  color: Color(0xFF263238),
                                  textColor: Colors.white,
                                  text: 'Edit',
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/navbar',
                                  index: 3,
                                  color: Color(0xFF42B1FF),
                                  text: 'Save',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/signin',
                                  color: Color.fromRGBO(159, 176, 183, 0.6),
                                  textColor: Colors.white,
                                  text: 'Log Out',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          const Row(
                            children: [
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/navbar',
                                  color: Color.fromARGB(255, 255, 88, 85),
                                  textColor: Colors.white,
                                  text: 'Delete Account',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "To change your password, ",
                                    style: TextStyle(
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 0.6),
                                        fontFamily: 'Poppins',
                                        fontSize: titleFontSize * 0.85,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "Click Here",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: titleFontSize * 0.85),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePasswordPage(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  );
                } else if (state is ProfileInitialState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Failed to load profile'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

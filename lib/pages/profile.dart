import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/pages/change_password.dart';
import 'package:moodify_mobile/bloc/profile/profile_bloc.dart';
import 'package:moodify_mobile/bloc/profile/profile_state.dart';
import 'package:moodify_mobile/bloc/profile/profile_event.dart';
import 'package:moodify_mobile/widgets/buttons/button.dart';

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
      create: (context) => ProfileBloc()
        ..add(LoadProfileEvent()), // Dispatch the LoadProfileEvent
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadedState) {
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
                                    const Text(
                                      "First Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFFA0D3F5).withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.firstName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const SizedBox(height: 13),
                                    const Text(
                                      "Last Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFFA0D3F5).withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.lastName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFA0D3F5).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.email,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFA0D3F5).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.gender,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            "Birth Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFA0D3F5).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.birthDate,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/navbar',
                                  color: Color(0xFF263238),
                                  textColor: Colors.white,
                                  text: 'Edit',
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: FillButtonRoute(
                                  route: '/navbar',
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
                                        // Arahkan ke halaman ChangePasswordPage
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
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text('Failed to load profile'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

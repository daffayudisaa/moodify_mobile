import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_event.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_state.dart';
import 'package:moodify_mobile/presentation/widgets/form/dropdown_dynamic.dart';
import 'package:moodify_mobile/presentation/widgets/form/dateofbirth_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  bool isEditing = false;
  String? gender;
  String? birthDate;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getimageSize = ScreenUtils.getFontSize(context, 80);

    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfile()),
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
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Profile",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getFontSize * 1.7,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF004373),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                MediaQuery.of(context).size.width - 60,
                                100,
                                20,
                                0,
                              ),
                              items: [
                                PopupMenuItem(
                                  value: 'change_password',
                                  child: PopupMenuItemWidget(
                                    title: 'Change Password',
                                    fontSize: getFontSize,
                                    icon: HugeIcons.strokeRoundedKey01,
                                    color: const Color(0xFF42B1FF),
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/change_password',
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'logout',
                                  child: PopupMenuItemWidget(
                                    fontSize: getFontSize,
                                    title: 'Log Out',
                                    icon: HugeIcons.strokeRoundedLogout02,
                                    color: const Color(0xFF004373),
                                    onTap: () async {
                                      context
                                          .read<AuthBloc>()
                                          .add(SignOutRequested());

                                      showDialog(
                                        context: context,
                                        builder: (context) => const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      );

                                      await Future.delayed(
                                          const Duration(seconds: 2));

                                      Navigator.pop(context);

                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/signin',
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete_account',
                                  child: PopupMenuItemWidget(
                                    fontSize: getFontSize,
                                    title: 'Delete Account',
                                    icon: HugeIcons.strokeRoundedDelete02,
                                    color: const Color(0xFFEC221F),
                                    onTap: () async {
                                      bool? confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
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
                                                'Delete Account',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                  fontSize: getFontSize * 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Text(
                                              'Are you sure want to Delete your Account?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: getFontSize * 0.9,
                                              ),
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              top: 15,
                                              bottom: 30),
                                          actions: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFFEF5350),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 15),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    shadowColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  ),
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            getFontSize * 1.1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 15),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.2)),
                                                    ),
                                                    shadowColor: Colors.grey,
                                                    elevation: 0,
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          getFontSize * 1.1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        );

                                        await Future.delayed(
                                            const Duration(seconds: 2));

                                        Navigator.pop(context);
                                        context
                                            .read<ProfileBloc>()
                                            .add(DeleteAccount());

                                        context
                                            .read<AuthBloc>()
                                            .add(SignOutRequested());

                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/signin',
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                              color: Colors.white,
                              elevation: 1.5);
                        },
                        icon: Icon(
                          Icons.more_vert,
                          size: getFontSize * 1.7,
                          color: const Color(0xFF004373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  String birthDateString =
                      DateFormat('yyyy-MM-dd').format(state.birthDate);

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
                  print(state.birthDate);
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _pickImage();
                                  if (_profileImage != null) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(UploadAvatar(_profileImage!));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Uploading Image"),
                                        backgroundColor: Colors.blue,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                      ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: getimageSize * 0.9,
                                  backgroundImage: CachedNetworkImageProvider(
                                    'https://sirw.my.id/users/avatar/${state.avatar}',
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: getFontSize * 1.4,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First Name",
                                      style: TextStyle(
                                        fontSize: getFontSize * 0.9,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    CustomTextField(
                                      hintText: 'First Name',
                                      controller: firstNameController,
                                      isEditing: !isEditing,
                                    ),
                                    const SizedBox(height: 13),
                                    Text(
                                      "Last Name",
                                      style: TextStyle(
                                        fontSize: getFontSize * 0.9,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    CustomTextField(
                                      hintText: 'Last Name',
                                      controller: lastNameController,
                                      isEditing: !isEditing,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: getFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomTextField(
                            hintText: 'Email',
                            controller: emailController,
                            isEditing: true,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: getFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DropdownDynamic(
                            initialValue: genderController.text,
                            items: const ['Male', 'Female'],
                            text: 'Gender',
                            enabled: isEditing,
                            onChanged: (value) {
                              gender = value;
                              genderController.text = gender!;
                            },
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "Birth Date",
                            style: TextStyle(
                              fontSize: getFontSize * 0.9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DateOfBirthInput(
                            controller: birthDateController,
                            enabled: isEditing,
                            onDateChanged: (date) {
                              birthDate = DateFormat('yyyy-MM-dd')
                                  .format(date ?? state.birthDate);
                              birthDateController.text = birthDate!;
                            },
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: FillButton(
                                  color: const Color.fromARGB(255, 15, 33, 42),
                                  textColor: Colors.white,
                                  text: 'Edit',
                                  onTap: () {
                                    setState(() {
                                      isEditing = true;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: FillButton(
                                    color: isEditing
                                        ? const Color(0xFF42B1FF)
                                        : const Color(0xFFECF4FF),
                                    textColor:
                                        isEditing ? Colors.white : Colors.grey,
                                    text: 'Save',
                                    onTap: isEditing
                                        ? () async {
                                            bool? confirm =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/Help.jpg',
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Confirm Save',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            getFontSize * 1.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                content: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Text(
                                                    'Are you sure you want to save these changes?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          getFontSize * 0.9,
                                                    ),
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 25,
                                                        right: 25,
                                                        top: 15,
                                                        bottom: 30),
                                                actions: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          foregroundColor:
                                                              Colors.black,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 15),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2)),
                                                          ),
                                                          shadowColor: Colors
                                                              .transparent,
                                                          elevation: 0,
                                                        ),
                                                        child: Text(
                                                          'Save',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                getFontSize *
                                                                    1.1,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Color(0xFFEF5350),
                                                          foregroundColor:
                                                              Colors.white,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 15),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          shadowColor: Colors
                                                              .transparent,
                                                          elevation: 0,
                                                        ),
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                getFontSize *
                                                                    1.1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (confirm == true) {
                                              final updatedFirstName =
                                                  firstNameController.text;
                                              final updatedLastName =
                                                  lastNameController.text;
                                              final updatedEmail =
                                                  emailController.text;
                                              final updatedGender =
                                                  genderController.text;
                                              final updatedBirthDate =
                                                  birthDateController.text;

                                              context
                                                  .read<ProfileBloc>()
                                                  .add(UpdateProfile(
                                                    firstName: updatedFirstName,
                                                    lastName: updatedLastName,
                                                    email: updatedEmail,
                                                    gender: updatedGender,
                                                    birthDate: updatedBirthDate,
                                                  ));
                                              setState(() {
                                                isEditing = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: const Text(
                                                    'Profile updated successfully!',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.only(
                                                      left: 20, right: 20),
                                                ),
                                              );
                                            }
                                          }
                                        : () {}),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ProfileError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
}

class PopupMenuItemWidget extends StatelessWidget {
  final double fontSize;
  final String title;
  final IconData? icon;
  final Color color;
  final VoidCallback onTap;

  const PopupMenuItemWidget({
    super.key,
    required this.fontSize,
    required this.title,
    this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: fontSize * 1.6,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: color,
            fontSize: fontSize * 1.05,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

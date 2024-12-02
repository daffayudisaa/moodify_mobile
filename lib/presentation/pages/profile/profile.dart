import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_state.dart';
import 'package:moodify_mobile/presentation/pages/change_password/change_password.dart';
import 'package:moodify_mobile/utils/screen_utils.dart';
import 'package:moodify_mobile/presentation/widgets/form/dateofbirth_picker.dart';
import 'package:moodify_mobile/presentation/widgets/form/dropdown_dynamic.dart';
import 'package:moodify_mobile/presentation/widgets/form/text_field.dart';
import 'package:moodify_mobile/presentation/widgets/buttons/button.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_event.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    double getFontSize = ScreenUtils.getFontSize(context, 14);
    double getimageSize = ScreenUtils.getFontSize(context, 80);

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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ChangePasswordPage(),
                                        ),
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
                                    onTap: () {
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: isEditing ? _pickImage : null,
                                child: CircleAvatar(
                                  radius: getimageSize * 0.9,
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : const AssetImage(
                                              'assets/images/User.jpg')
                                          as ImageProvider,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isEditing == false
                                                ? Colors.grey
                                                : Colors.blue,
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
                            isEditing: !isEditing,
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
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: FillButton(
                                  color: const Color(0xFF263238),
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
                                  color: const Color(0xFF42B1FF),
                                  text: 'Save',
                                  onTap: () async {
                                    bool? confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Confirm Save'),
                                        content: const Text(
                                            'Are you sure you want to save the changes?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm ?? false) {
                                      context.read<ProfileBloc>().add(
                                            UpdateProfileEvent(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              gender: genderController.text,
                                              birthDate: DateFormat(
                                                      'dd-MM-yyyy')
                                                  .parse(
                                                      birthDateController.text),
                                            ),
                                          );
                                      setState(() {
                                        isEditing = false;
                                      });
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

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery, // atau ImageSource.camera
      imageQuality: 80, // Kualitas gambar
      maxWidth: 1080, // Resolusi maksimum
    );

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
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

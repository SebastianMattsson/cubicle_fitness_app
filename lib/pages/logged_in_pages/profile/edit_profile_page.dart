// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:cubicle_fitness/widgets/gender_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  String genderSelected = "Female";
  String? initialGender;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    void _showDatePicker() async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(DateTime.now().year - 70),
          lastDate: DateTime.now());

      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
          dateOfBirthController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);
        });
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.tertiary),
          title: Text(
            "Edit Profile",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: FutureBuilder<UserModel?>(
                    future: db.getUserData(currentUser.email),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator while data is being fetched
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Text(
                            'User not found'); // Handle the case when user data is not available
                      } else {
                        UserModel user = snapshot.data!;
                        if (initialGender == null) {
                          initialGender = user.gender;
                          genderSelected = initialGender!;
                          // Set initial values to controllers here
                          nameController.text = user.name;
                          surnameController.text = user.surname;
                          dateOfBirthController.text = user.dateOfBirth;
                          try {
                            selectedDate = DateTime.parse(user.dateOfBirth);
                          } catch (e) {}
                        }

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              // Stack(
                              //   children: [
                              //     Container(
                              //       height: 150,
                              //       width: 150,
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         border: Border.all(
                              //             color: Theme.of(context)
                              //                 .colorScheme
                              //                 .primary,
                              //             width: 3),
                              //       ),
                              //       child: ClipRRect(
                              //         borderRadius: BorderRadius.circular(100),
                              //         child: Image(
                              //             fit: BoxFit.cover,
                              //             image: NetworkImage(user.image)),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              FormTextField(
                                label: "Firstname",
                                hintText: "Firstname",
                                controller: nameController,
                                icon: Icons.person,
                              ),
                              FormTextField(
                                label: "Surname",
                                hintText: "Surname",
                                controller: surnameController,
                                icon: Icons.person,
                              ),
                              FormTextField(
                                  label: "Age",
                                  hintText: "Date of birth",
                                  onTap: _showDatePicker,
                                  controller: dateOfBirthController,
                                  keyboardType: TextInputType.datetime,
                                  icon: Icons.calendar_month),
                              GenderDropdown(
                                label: "Gender",
                                onGenderSelected: (value) {
                                  setState(() {
                                    genderSelected = value;
                                  });
                                },
                                genderSelected: genderSelected,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    UserModel updatedUser = UserModel(
                                        id: user.id,
                                        name: nameController.text.trim(),
                                        surname: surnameController.text.trim(),
                                        companyId: user.companyId,
                                        activities: user.activities,
                                        email: user.email,
                                        gender: genderSelected,
                                        dateOfBirth:
                                            dateOfBirthController.text.trim(),
                                        image: user.image,
                                        notifications: user.notifications);

                                    await db.updateUser(updatedUser);

                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: StadiumBorder(),
                                      elevation: 6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Save Changes",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 20,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    })))));
  }
}

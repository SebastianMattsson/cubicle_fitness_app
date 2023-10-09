// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNewCompanyPage extends StatefulWidget {
  const CreateNewCompanyPage({super.key});

  @override
  State<CreateNewCompanyPage> createState() => _CreateNewCompanyPageState();
}

class _CreateNewCompanyPageState extends State<CreateNewCompanyPage> {
  final nameController = TextEditingController();
  final maxController = TextEditingController();
  final goalController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();
  UserModel? user; // Variable to store user data

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initialized
  }

  // Function to fetch user data
  Future<void> _fetchUserData() async {
    try {
      UserModel? userData = await db.getUserData(currentUser.email);
      setState(() {
        user = userData;
      });
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FormTextField(
            label: "Company name",
            hintText: "Enter the company name",
            controller: nameController,
            icon: Icons.supervised_user_circle),
        FormTextField(
            label: "Max workouts weekly",
            hintText: "Enter max",
            keyboardType: TextInputType.number,
            controller: maxController,
            icon: Icons.numbers),
        FormTextField(
            label: "Weekly goal",
            hintText: "Enter weekly goal",
            keyboardType: TextInputType.number,
            controller: goalController,
            icon: Icons.grade_outlined),
        ElevatedButton(
            onPressed: () async {
              if (user != null) {
                String companyName = nameController.text;
                int maxWorkouts = int.tryParse(maxController.text) ?? 0;
                int weeklyGoal = int.tryParse(goalController.text) ?? 0;

                await db.createNewCompany(
                    companyName, maxWorkouts, weeklyGoal, user!);
              }
            },
            child: Text("Create your comapny"))
      ]),
    );
  }
}

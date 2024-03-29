import 'package:cubicle_fitness/models/user.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Create Company",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome to Your Company Fitness Hub!",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary),
            ),
            SizedBox(height: 20),
            Text(
              "Create a new company to provide fitness programs for your employees. Define maximum workouts allowed per week and set a weekly goal to keep everyone active.",
              style: TextStyle(
                  fontSize: 16,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
            ),
            SizedBox(height: 40),
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
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (user != null) {
                      String companyName = nameController.text;
                      int maxWorkouts = int.tryParse(maxController.text) ?? 0;
                      int weeklyGoal = int.tryParse(goalController.text) ?? 0;

                      await db.createNewCompany(
                          companyName, maxWorkouts, weeklyGoal, user!);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: StadiumBorder(),
                      elevation: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Create your Company",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

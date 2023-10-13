import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/form_TF.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateActivityPage extends StatelessWidget {
  CreateActivityPage({super.key});

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final minParticipantsController = TextEditingController();
  final maxParticipantsController = TextEditingController();
  final locationController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Create New Activity",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  "Organize engaging fitness activities for your company members to promote a healthy lifestyle and team spirit. Fill in the details below to create a memorable fitness activity!",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.8)),
                ),
              ),
              SizedBox(height: 40),
              SingleChildScrollView(
                child: Column(
                  children: [
                    FormTextField(
                        label: "Activity Name",
                        hintText: "Enter the activity name",
                        controller: nameController,
                        icon: Icons.fitness_center),
                    FormTextField(
                        label: "Description",
                        hintText: "Enter activity description",
                        controller: descriptionController,
                        icon: Icons.description),
                    FormTextField(
                        label: "Minimum participants",
                        hintText: "Enter activity date and time",
                        controller: minParticipantsController,
                        icon: Icons.numbers),
                    FormTextField(
                        label: "Minimum participants",
                        hintText: "Enter activity date and time",
                        controller: maxParticipantsController,
                        icon: Icons.numbers),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle create activity logic here
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: StadiumBorder(),
                        elevation: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Create Activity",
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
      ),
    );
  }
}

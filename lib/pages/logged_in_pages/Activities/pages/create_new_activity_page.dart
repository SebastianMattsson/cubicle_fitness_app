// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cubicle_fitness/models/activity.dart';
import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/category_step_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/confirm_step_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/general_step_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/pages/participants_step_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateActivityPage extends StatefulWidget {
  CreateActivityPage({super.key});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final db = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final currentUser = FirebaseAuth.instance.currentUser!;

  //Controllers for the general step
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final costController = TextEditingController();
  final dateTimeController = TextEditingController();
  final locationController = TextEditingController();
  final repeatDurationController = TextEditingController();
  String repeatFrequencySelected = "Never";

  //Controllers for the participations step
  final minController = TextEditingController();
  final maxController = TextEditingController();

  CategoryModel? selectedCategory;

  void createActivities(UserModel userData) async {
    // Parse the selected date
    DateTime selectedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeController.text.trim());

    if (repeatFrequencySelected == 'Never') {
      var activity = ActivityModel(
        companyId: userData.companyId!,
        isParentActivity: true,
        name: nameController.text.trim(),
        categoryId: selectedCategory!.id!,
        description: descriptionController.text.trim(),
        cost: int.parse(costController.text),
        dateTime: dateTimeController.text.trim(),
        repeated: repeatFrequencySelected,
        location: locationController.text.trim(),
        participants: [userData.id!],
        minParticipants: int.parse(minController.text.trim()),
        maxParticipants: int.parse(maxController.text.trim()),
      );
      await db.createNewActivity(activity);
    } else {
      // Calculate the date a week from the selected date
      var repeatDuration = int.parse(repeatDurationController.text.trim());
      var isParentActivity = true;
      var parentId;
      // Create activities for the next 7 days
      for (int i = 0; i < repeatDuration; i++) {
        i == 0 ? isParentActivity = true : isParentActivity = false;

        var activity = ActivityModel(
            companyId: userData.companyId!,
            isParentActivity: isParentActivity,
            parentId: parentId,
            name: nameController.text.trim(),
            categoryId: selectedCategory!.id!,
            description: descriptionController.text.trim(),
            cost: int.parse(costController.text),
            dateTime: DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime),
            repeated: repeatFrequencySelected,
            location: locationController.text.trim(),
            participants: [],
            minParticipants: int.parse(minController.text.trim()),
            maxParticipants: int.parse(maxController.text.trim()));

        // Add the activity to the database
        var activityId = await db.createNewActivity(activity);

        if (i == 0) {
          parentId = activityId;
        }

        // Increment the date for the next iteration
        selectedDateTime = selectedDateTime.add(Duration(days: 7));
      }
    }
  }

  void onCategorySelected(CategoryModel? pickedCategory) {
    setState(() {
      if (selectedCategory != null) {
        if (selectedCategory!.name == pickedCategory!.name) {
          selectedCategory = null;
        } else {
          selectedCategory = pickedCategory;
        }
      } else {
        selectedCategory = pickedCategory;
      }
    });
  }

  List<Step> stepList() => [
        Step(
            title: Text("Category"),
            content: CategoryStep(
                selectedCategory: selectedCategory,
                onCategorySelected: onCategorySelected),
            state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 0),
        Step(
            title: Text("General"),
            content: Form(
              key: _formKey,
              child: GeneralStep(
                nameController: nameController,
                descriptionController: descriptionController,
                costController: costController,
                dateTimeController: dateTimeController,
                locationController: locationController,
                repeatFrequencySelected: repeatFrequencySelected,
                repeatDurationController: repeatDurationController,
                onFrequencyChanged: (value) {
                  setState(() {
                    repeatFrequencySelected = value;
                  });
                },
              ),
            ),
            state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 1),
        Step(
            title: Text("Participants"),
            content: ParticipantsStep(
              minController: minController,
              maxController: maxController,
            ),
            state: _currentStep <= 2 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 2),
        Step(
            title: Text("Confirm"),
            content: ConfirmStep(
                category: selectedCategory ??
                    CategoryModel(name: "name", image: "image"),
                name: nameController.text.trim(),
                description: descriptionController.text.trim(),
                cost: costController.text.trim(),
                dateTime: dateTimeController.text.trim(),
                location: locationController.text.trim(),
                repeatFrequencySelected: repeatFrequencySelected,
                repeatDuration: repeatDurationController.text.trim(),
                min: minController.text.trim(),
                max: maxController.text.trim()),
            state: _currentStep <= 3 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 3),
      ];

  int _currentStep = 0;

  bool isStepCompleted() {
    if (_currentStep == 0) {
      if (selectedCategory != null) {
        return true;
      } else {
        return false;
      }
    } else if (_currentStep == 1) {
      if (_formKey.currentState?.validate() ?? false) {
        return true;
      } else {
        return false;
      }
    } else if (_currentStep == 2) {
      if (minController.text.isNotEmpty && maxController.text.isNotEmpty) {
        if (int.parse(minController.text) > int.parse(maxController.text)) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } else if (_currentStep == 3) {
      return true;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.tertiary),
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
        body: StreamBuilder<UserModel?>(
          stream: db.getUserStreamByEmail(currentUser.email!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data!;
              return Stepper(
                currentStep: _currentStep,
                onStepContinue: () async {
                  if (_currentStep < (stepList().length)) {
                    if (isStepCompleted()) {
                      if (_currentStep == 3) {
                        if (userData.companyId != null &&
                            selectedCategory?.id != null) {
                          createActivities(userData);

                          Navigator.pop(context);
                        }
                      } else {
                        _currentStep += 1;
                        setState(() {});
                      }
                    }
                  }
                },
                onStepCancel: () {
                  if (_currentStep == 0) {
                    return;
                  }
                  _currentStep -= 1;
                  setState(() {});
                },
                //type: StepperType.horizontal,
                steps: stepList(),
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(12),
                                      elevation: 10,
                                      shape: StadiumBorder(),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  child: Text(
                                    _currentStep == 3 ? "Confirm" : "Next",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontFamily: 'Roboto',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          if (_currentStep != 0)
                            SizedBox(
                              width: 20,
                            ),
                          if (_currentStep != 0)
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(12),
                                        elevation: 10,
                                        shape: StadiumBorder(),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.6)),
                                    onPressed: details.onStepCancel,
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontFamily: 'Roboto',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    )))
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("Something went wrong");
            }
          },
        ));
  }
}

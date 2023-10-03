// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/widgets/company_step.dart';
import 'package:cubicle_fitness/widgets/extras_step.dart';
import 'package:cubicle_fitness/widgets/user_step.dart';
import 'package:flutter/material.dart';

class RegisterStepper extends StatefulWidget {
  const RegisterStepper({super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  List<Step> getSteps() => [
        Step(
            title: Text(
              "Company",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            content: CompanyStep(),
            isActive: currentStep >= 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed),
        Step(
            title: Text(
              "User",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            content: UserStep(),
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed),
        Step(
            title: Text(
              "Extras",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            content: ExtrasStep(),
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed),
        Step(
            title: Text(
              "Confirm",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(),
            isActive: currentStep >= 3),
      ];
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          canvasColor: Theme.of(context).colorScheme.primary,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Theme.of(context).colorScheme.background,
              )),
      child: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        controlsBuilder: (context, methods) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: methods.onStepContinue,
                style: ElevatedButton.styleFrom(
                    elevation: 8,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Roboto',
                      letterSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: methods.onStepCancel,
                style: ElevatedButton.styleFrom(
                    elevation: 8,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "BACK",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Roboto',
                      letterSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
          );
        },
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (isLastStep) {
            print("Last step reached");
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          final isFirstStep = currentStep == 0;
          if (isFirstStep) {
            Navigator.pop(context);
          } else {
            setState(() {
              currentStep -= 1;
            });
          }
        },
      ),
    );
  }
}

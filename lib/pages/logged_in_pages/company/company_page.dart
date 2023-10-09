// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/create_new_company_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final companyStream =
        FirestoreService().getCompanyStreamForUser(currentUser.email!);

    return Scaffold(
      body: Center(
        child: StreamBuilder<CompanyModel?>(
          stream: companyStream,
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return CircularProgressIndicator(); // Loading indicator while fetching user data
            // }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null || !snapshot.hasData) {
              // User does not belong to a company, show buttons
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateNewCompanyPage(),
                      ),
                    ),
                    child: Text("Create new Company"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Join existing company"),
                  ),
                ],
              );
            } else {
              // User belongs to a company, display something else
              var companyData = snapshot.data!;
              return Column(
                children: [
                  Text("Name: ${companyData.name}"),
                  Text("CreatorId: ${companyData.creatorId}"),
                  Text("Max: ${companyData.maxActivitiesPerWeek}"),
                  Text("Goal: ${companyData.activitiesPerWeekGoal}"),
                  Text("Image: ${companyData.image}"),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

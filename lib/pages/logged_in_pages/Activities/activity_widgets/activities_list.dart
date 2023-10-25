// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/activity_tile.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActivitiesList extends StatelessWidget {
  ActivitiesList({super.key});
  final db = FirestoreService();

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.getUserStreamByEmail(currentUser.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while fetching user data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var userData = snapshot.data!;
            if (userData.companyId == null) {
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: Text(
                    "You dont belong to a company",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )));
            } else {
              return StreamBuilder<CompanyModel?>(
                  stream: db.getCompanyStreamForUser(currentUser.email!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      var companyData = snapshot.data!;

                      return StreamBuilder(
                          stream:
                              db.getCompaniesActivitiesStream(companyData.id!),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              var activities = snapshot.data!;
                              return ListView.separated(
                                  itemBuilder: (context, index) => ActivityTile(
                                        activityData: activities[index],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: activities.length);
                            }
                          }));
                    }
                  });
            }
          }
        });
  }
}

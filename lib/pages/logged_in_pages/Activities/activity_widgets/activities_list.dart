// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cubicle_fitness/models/activity.dart';
import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/parent_activity_tile.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ActivitiesList extends StatelessWidget {
  ActivitiesList({super.key});
  final db = FirestoreService();

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<bool> _showBottomSheet(
      BuildContext context, ActivityModel activity) async {
    var delete = false;
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
                onTap: () {
                  delete = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
    return delete;
  }

  Future<void> _showAlertMessage(
      BuildContext context, ActivityModel activity) async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: activity.repeated == "Never"
          ? "Are you sure you want to delete ${activity.name}"
          : "Are you sure you want to delete ${activity.name}?\nYou will also delete future activities.",
      onConfirmBtnTap: () async {
        Navigator.pop(context);
        await db.deleteActivity(activity);
      },
      customAsset: "lib/images/running.jpg",
      confirmBtnText: "Yes",
      cancelBtnText: "No",
      confirmBtnColor: Colors.green,
      cancelBtnTextStyle: TextStyle(color: Colors.red),
      textColor: Theme.of(context).colorScheme.tertiary,
      titleColor: Theme.of(context).colorScheme.tertiary,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

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
                          stream: db.getActivitiesWhereIsParentActivityStream(
                              companyData.id!),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              var activities = snapshot.data!;
                              return ListView.separated(
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () async {
                                          bool delete = await _showBottomSheet(
                                              context, activities[index]);

                                          if (delete) {
                                            await _showAlertMessage(
                                                context, activities[index]);
                                          }
                                        },
                                        child: ParentActivityTile(
                                          activityData: activities[index],
                                        ),
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

// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_highlights.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_info.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/no_company_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/glass_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final userStream =
        FirestoreService().getUserStreamByEmail(currentUser.email!);
    final db = FirestoreService();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: StreamBuilder<UserModel?>(
            stream: userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Loading indicator while fetching user data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var userData = snapshot.data!;
                if (userData.companyId == null) {
                  return NoCompanyPage();
                } else {
                  return StreamBuilder<CompanyModel?>(
                      stream: db.getCompanyStream(userData.companyId!),
                      builder: (context, companySnapshot) {
                        if (companySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (companySnapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (companySnapshot.hasData) {
                          var companyData = companySnapshot.data!;
                          var isCreator = companyData.creatorId == userData.id
                              ? true
                              : false;
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "lib/images/company.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: GlassBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 70),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            companyData.name,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  width: 3),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "lib/images/company.jpg")),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    CompanyInfo(
                                        isCreator: isCreator,
                                        companyData: companyData,
                                        userData: userData),
                                    Positioned(
                                        top: -50,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary
                                                        .withOpacity(0.2),
                                                    offset: Offset(0, 2),
                                                    blurRadius: 6.0,
                                                  )
                                                ]),
                                            child: CompanyHighlight(
                                              companyData: companyData,
                                              userData: userData,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          );
                        } else {
                          return Text("Something went wrong");
                        }
                      });
                }
              }
            }),
      ),
    );
  }
}

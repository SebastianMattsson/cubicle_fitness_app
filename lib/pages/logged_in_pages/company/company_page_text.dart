// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/create_new_company_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/search_company_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/company_highlight_tile.dart';
import 'package:cubicle_fitness/widgets/glass_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final userStream =
        FirestoreService().getUserStreamByEmail(currentUser.email!);
    final db = FirestoreService();

    void leaveCompany(CompanyModel company, UserModel user) async {
      if (user != null) {
        if (user.id != company.creatorId) {
          await db.leaveCompany(user, company);
        }
      }

      Navigator.pop(context);
    }

    return Scaffold(
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
                  return Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateNewCompanyPage(),
                            ),
                          ),
                          child: Text("Create new Company"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchForCompanyPage(),
                            ),
                          ),
                          child: Text("Join existing company"),
                        ),
                      ],
                    ),
                  );
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
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
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
                                                  image: AssetImage(
                                                      "lib/images/google.png")),
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
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .background,
                                            Theme.of(context)
                                                .colorScheme
                                                .primary
                                          ],
                                          stops: [0.3, 1.2],
                                        ),
                                      ),
                                    ),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                StreamBuilder<UserModel?>(
                                                    stream:
                                                        db.getUserStreamById(
                                                            companyData
                                                                .creatorId),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return CircularProgressIndicator();
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            'Error: ${snapshot.error}');
                                                      } // Loading indicator while fetching user data
                                                      else {
                                                        var creatorData =
                                                            snapshot.data!;
                                                        return Container(
                                                          width: 100,
                                                          height: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Creator",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .primary,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border: Border.all(
                                                                            color:
                                                                                Theme.of(context).colorScheme.primary,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                        child: Image(
                                                                            image:
                                                                                NetworkImage(creatorData.image)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                VerticalDivider(
                                                  thickness: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                      .withOpacity(0.2),
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                CompanyHighlightTile(
                                                    label: "Members",
                                                    text: companyData
                                                        .members.length
                                                        .toString()),
                                                VerticalDivider(
                                                  thickness: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                      .withOpacity(0.2),
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                CompanyHighlightTile(
                                                    label: "Activities",
                                                    text: "20".toString())
                                              ],
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        top: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("data")),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("data")),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          shape:
                                                              StadiumBorder(),
                                                          elevation: 6),
                                                  onPressed: () {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType
                                                          .confirm,
                                                      text:
                                                          "Are you sure you want to leave ${companyData.name}",
                                                      onConfirmBtnTap: () {
                                                        leaveCompany(
                                                            companyData,
                                                            userData);
                                                      },
                                                      customAsset:
                                                          "lib/images/company.jpg",
                                                      confirmBtnText: "Yes",
                                                      cancelBtnText: "No",
                                                      confirmBtnColor:
                                                          Colors.green,
                                                      cancelBtnTextStyle:
                                                          TextStyle(
                                                              color:
                                                                  Colors.red),
                                                      textColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .tertiary,
                                                      titleColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .tertiary,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                    );
                                                  },
                                                  child: Text("Leave Company",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary))),
                                            ],
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/models/activity.dart';
import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_content.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_highlights.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_info.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/members_list.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/pages/no_company_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/pages/requests_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/glass_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:quickalert/quickalert.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final userStream =
        FirestoreService().getUserStreamByEmail(currentUser.email!);
    final db = FirestoreService();

    void onSelected(BuildContext context, int item, bool isCreator,
        CompanyModel companyData, UserModel userData) {
      switch (item) {
        case 1:
          QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            text: isCreator
                ? "Are you sure you want to delete ${companyData.name}"
                : "Are you sure you want to leave ${companyData.name}",
            onConfirmBtnTap: () async {
              Navigator.pop(context);
              isCreator
                  ? await db.deleteCompany(companyData, userData)
                  : await db.leaveCompany(userData, companyData);
            },
            customAsset: "lib/images/company.jpg",
            confirmBtnText: "Yes",
            cancelBtnText: "No",
            confirmBtnColor: Colors.green,
            cancelBtnTextStyle: TextStyle(color: Colors.red),
            textColor: Theme.of(context).colorScheme.tertiary,
            titleColor: Theme.of(context).colorScheme.tertiary,
            backgroundColor: Theme.of(context).colorScheme.background,
          );
      }
    }

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
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          var companyData = snapshot.data!;
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
                                    padding: const EdgeInsets.only(top: 60),
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
                                  ),
                                  Positioned(
                                      top: 15,
                                      right: 15,
                                      child: Row(
                                        children: [
                                          isCreator
                                              ? StreamBuilder(
                                                  stream: db
                                                      .getCompaniyJoinRequests(
                                                          companyData.id!),
                                                  builder:
                                                      ((context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator(); // Loading indicator while fetching user data
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      var joinRequests =
                                                          snapshot.data!;

                                                      return GestureDetector(
                                                        onTap: () =>
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            RequestsPage(
                                                                              company: companyData,
                                                                              creator: userData,
                                                                            ))),
                                                        child: badges.Badge(
                                                          badgeStyle: badges.BadgeStyle(
                                                              badgeColor: Theme
                                                                      .of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          showBadge:
                                                              joinRequests
                                                                  .isNotEmpty,
                                                          badgeContent: Text(
                                                              joinRequests
                                                                  .length
                                                                  .toString()),
                                                          child: Icon(
                                                              Icons.person_add),
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                )
                                              : SizedBox(),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                                iconTheme: IconThemeData(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary)),
                                            child: PopupMenuButton<int>(
                                                onSelected: (item) =>
                                                    onSelected(
                                                        context,
                                                        item,
                                                        isCreator,
                                                        companyData,
                                                        userData),
                                                itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                          value: 0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Settings"),
                                                              Icon(Icons
                                                                  .settings)
                                                            ],
                                                          )),
                                                      PopupMenuItem(
                                                          value: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(isCreator
                                                                  ? "Delete Company"
                                                                  : "Leave Company"),
                                                              Icon(isCreator
                                                                  ? Icons.delete
                                                                  : Icons
                                                                      .arrow_forward_ios_outlined)
                                                            ],
                                                          )),
                                                    ]),
                                          )
                                        ],
                                      ))
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
                                              horizontal: 20),
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
                                                    color: Colors.black26,
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

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/members_list.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class CompanyInfo extends StatelessWidget {
  final bool isCreator;
  final CompanyModel companyData;
  final UserModel userData;

  CompanyInfo(
      {super.key,
      required this.isCreator,
      required this.companyData,
      required this.userData});

  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60, right: 20, left: 20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MembersList(label: "Members", companyData: companyData),
            ],
          ),
        ),
      ),
    );
  }
}

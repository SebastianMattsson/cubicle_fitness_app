import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_button.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_content.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/members_list.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

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
              CompanyButton(
                  onPress: () {
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
                  },
                  text: isCreator ? "Delete Company" : "Leave Company"),
            ],
          ),
        ),
      ),
    );
  }
}

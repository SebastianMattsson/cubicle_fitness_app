import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/member_tile.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class MembersListPage extends StatelessWidget {
  final CompanyModel company;
  MembersListPage({super.key, required this.company});

  final db = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.tertiary),
          title: Text(
            "Members",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: StreamBuilder<List<UserModel>>(
            stream: db.getMembersInCompanyStream(company.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Loading indicator while fetching user data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var members = snapshot.data!;
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          var isCreator =
                              members[index].id == company.creatorId;
                          return MemberTile(
                            member: members[index],
                            isCreator: isCreator,
                          );
                        }));
              }
            }));
  }
}

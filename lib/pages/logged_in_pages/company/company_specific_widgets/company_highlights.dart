import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/company_highlight_tile.dart';
import 'package:flutter/material.dart';

class CompanyHighlight extends StatelessWidget {
  final UserModel userData;
  final CompanyModel companyData;
  CompanyHighlight(
      {super.key, required this.userData, required this.companyData});

  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder<UserModel?>(
            stream: db.getUserStreamById(companyData.creatorId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } // Loading indicator while fetching user data
              else {
                var creatorData = snapshot.data!;
                return Container(
                  width: 100,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        "Creator",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                Image(image: NetworkImage(creatorData.image)),
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
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          indent: 10,
          endIndent: 10,
        ),
        CompanyHighlightTile(
            label: "Members", text: companyData.members.length.toString()),
        VerticalDivider(
          thickness: 1,
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          indent: 10,
          endIndent: 10,
        ),
        CompanyHighlightTile(
            label: "Activities", text: companyData.activities.length.toString())
      ],
    );
  }
}

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class MembersList extends StatelessWidget {
  final String label;
  final CompanyModel companyData;
  MembersList({Key? key, required this.label, required this.companyData})
      : super(key: key);
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: db.getMembersInCompanyStream(companyData.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var membersData = snapshot.data as List<UserModel>;
                return Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: membersData.length,
                    itemBuilder: (context, index) =>
                        buildMemberCard(context, membersData[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      width: 20,
                    ),
                  ),
                );
              }
            })
      ],
    );
  }

  Widget buildMemberCard(BuildContext context, UserModel member) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image(fit: BoxFit.cover, image: NetworkImage(member.image)),
          ),
        ),
        Text(
          "${member.name} ${member.surname}",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 12,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

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
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Roboto',
                      fontSize: 22,
                    )),
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

                        return Row(children: [
                          for (int i = 0;
                              membersData.length > 4
                                  ? i < 5
                                  : i < membersData.length;
                              i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Align(
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(membersData[i].image),
                                  ),
                                ),
                              ),
                            )
                        ]);

                        // return Container(
                        //   height: 100,
                        //   child: ListView.separated(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: membersData.length,
                        //     itemBuilder: (context, index) =>
                        //         buildMemberCard(context, membersData[index]),
                        //     separatorBuilder: (BuildContext context, int index) =>
                        //         SizedBox(
                        //       width: 20,
                        //     ),
                        //   ),
                        // );
                      }
                    })
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  // Widget buildMemberCard(BuildContext context, UserModel member) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 60,
  //         width: 60,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //               color: Theme.of(context).colorScheme.primary, width: 1),
  //         ),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(100),
  //           child: Image(fit: BoxFit.cover, image: NetworkImage(member.image)),
  //         ),
  //       ),
  //       Text(
  //         "${member.name} ${member.surname}",
  //         style: TextStyle(
  //             color: Theme.of(context).colorScheme.tertiary,
  //             fontFamily: 'Roboto',
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold),
  //       )
  //     ],
  //   );
  // }
}

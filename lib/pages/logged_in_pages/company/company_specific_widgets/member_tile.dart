import 'package:cubicle_fitness/models/user.dart';
import 'package:flutter/material.dart';

class MemberTile extends StatelessWidget {
  final UserModel member;
  final bool isCreator;
  const MemberTile({super.key, required this.member, required this.isCreator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(member.image),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                  "${member.name} ${member.surname}${isCreator ? " (Creator)" : ""}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

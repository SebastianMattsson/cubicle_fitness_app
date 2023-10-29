// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/join_request.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatefulWidget {
  final JoinRequestModel joinRequest;
  final CompanyModel company;
  final UserModel creator;
  RequestTile(
      {super.key,
      required this.joinRequest,
      required this.company,
      required this.creator});

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: StreamBuilder(
          stream: db.getUserStreamById(widget.joinRequest.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator while fetching user data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var userData = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(userData.image),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "${userData.name} ${userData.surname} sent you a request to join ${widget.company.name}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  await db.acceptJoinRequest(
                                      widget.company,
                                      userData,
                                      widget.creator,
                                      widget.joinRequest);
                                },
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                ))),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  await db.declineJoinRequest(
                                      widget.company,
                                      userData,
                                      widget.creator,
                                      widget.joinRequest);
                                },
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                )))
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}

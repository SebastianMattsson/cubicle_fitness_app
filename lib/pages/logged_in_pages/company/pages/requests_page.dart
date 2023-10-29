// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/join_request.dart';
import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/company_specific_widgets/request_tile.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  final CompanyModel company;
  final UserModel creator;
  RequestsPage({super.key, required this.company, required this.creator});

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
            "Join Requests",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: StreamBuilder<List<JoinRequestModel>>(
            stream: db.getCompaniyJoinRequests(company.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Loading indicator while fetching user data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var joinRequests = snapshot.data!;
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: joinRequests.length < 1
                        ? Center(
                            child: Text("No new requests"),
                          )
                        : ListView.builder(
                            itemCount: joinRequests.length,
                            itemBuilder: (context, index) {
                              return RequestTile(
                                joinRequest: joinRequests[index],
                                company: company,
                                creator: creator,
                              );
                            }));
              }
            }));
  }
}

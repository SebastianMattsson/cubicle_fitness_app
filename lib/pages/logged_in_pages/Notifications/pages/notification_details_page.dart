// ignore_for_file: prefer_const_constructors

import 'package:cubicle_fitness/models/notification.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Notifications/widgets/notification_details_text.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatelessWidget {
  final NotificationModel notification;
  NotificationDetailsPage({super.key, required this.notification});

  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          notification.notificationType,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            StreamBuilder(
                stream: db.getUserStreamById(notification.senderId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Loading indicator while fetching user data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var userData = snapshot.data!;

                    return Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(userData.image)),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NotificationText(
                                  text: "${userData.name} ${userData.surname}",
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              NotificationText(
                                text: userData.email,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.6),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 20,
            ),
            NotificationText(
                text: "Title", fontSize: 22, fontWeight: FontWeight.bold),
            SizedBox(
              height: 5,
            ),
            NotificationText(
                text: notification.title,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 20,
            ),
            NotificationText(
                text: "Description", fontSize: 22, fontWeight: FontWeight.bold),
            SizedBox(
              height: 10,
            ),
            NotificationText(
              text: notification.description,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
            ),
            SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}

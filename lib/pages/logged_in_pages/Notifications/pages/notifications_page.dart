// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cubicle_fitness/models/notification.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Notifications/pages/notification_details_page.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontFamily: 'Roboto',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
            stream: db.getUserStreamByEmail(currentUser.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var userData = snapshot.data!;
                return StreamBuilder(
                  stream: db.getNotificationsByIds(userData.id!),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var notificationsData = snapshot.data!;
                      if (notificationsData.length <= 0) {
                        return Center(child: Text("No notifications"));
                      } else {
                        notificationsData
                            .sort((a, b) => b.timestamp.compareTo(a.timestamp));

                        List<NotificationModel> readNotifications = [];
                        List<NotificationModel> unreadNotifications = [];
                        notificationsData.forEach((notification) {
                          if (notification.isRead) {
                            readNotifications.add(notification);
                          } else {
                            unreadNotifications.add(notification);
                          }
                        });

                        return ListView(
                          children: [
                            if (unreadNotifications.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'Unread',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ...unreadNotifications.map((notification) {
                              var formattedDate = DateFormat('E d MMMM HH:mm')
                                  .format(notification.timestamp.toDate());
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!notification.isRead) {
                                      notification.isRead = true;
                                      await db.updateNotification(notification);
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationDetailsPage(
                                          notification: notification,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notification.notificationType,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                notification.title,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                      .withOpacity(0.6),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: !notification.isRead
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Icon(Icons.notifications),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            if (readNotifications.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'Read',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ...readNotifications.map((notification) {
                              var formattedDate = DateFormat('E d MMMM HH:mm')
                                  .format(notification.timestamp.toDate());
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!notification.isRead) {
                                      notification.isRead = true;
                                      await db.updateNotification(notification);
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationDetailsPage(
                                          notification: notification,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notification.notificationType,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                notification.title,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                      .withOpacity(0.6),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: !notification.isRead
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Icon(Icons.notifications),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    }
                  }),
                );
              }
            }),
      ),
    );
  }
}

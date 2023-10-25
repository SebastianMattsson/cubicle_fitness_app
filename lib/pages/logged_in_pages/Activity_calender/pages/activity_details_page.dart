// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cubicle_fitness/models/activity.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ActivityDetailsPage extends StatefulWidget {
  final ActivityModel activityData;
  final UserModel user;

  ActivityDetailsPage({required this.activityData, required this.user});

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  late bool _isRegistered;
  late bool _isFull;

  final db = FirestoreService();

  void checkActivity() {
    setState(() {
      _isRegistered = widget.activityData.participants.contains(widget.user.id);
      _isFull = widget.activityData.participants.length >=
          widget.activityData.maxParticipants;
    });
  }

  void leaveActivity() async {
    setState(() {
      widget.activityData.participants.remove(widget.user.id);
    });
    await db.updateActivity(widget.activityData);
    checkActivity();
  }

  void joinActivity() async {
    setState(() {
      widget.activityData.participants.add(widget.user.id);
    });
    await db.updateActivity(widget.activityData);
    checkActivity();
  }

  @override
  void initState() {
    super.initState();
    // Initialize _isRegistered and _isFull based on your conditions
    checkActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Activity Details",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("lib/images/running.jpg")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.activityData.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.6),
                                ),
                                Text(
                                  widget.activityData.location,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primary),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              widget.activityData.cost == 0
                                  ? "Free"
                                  : "\$ ${widget.activityData.cost.toString()}",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.6),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Align(
                            widthFactor: 0.5,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage("lib/images/company.jpg"),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.activityData.participants.length} / ${widget.activityData.maxParticipants} participants",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.6),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 22,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            widget.activityData.description,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.6),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 8.0,
                    )
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_isRegistered) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        text:
                            "Are you sure you want to leave ${widget.activityData.name}",
                        onConfirmBtnTap: () async {
                          Navigator.pop(context);
                          leaveActivity();
                        },
                        customAsset: "lib/images/company.jpg",
                        confirmBtnText: "Yes",
                        cancelBtnText: "No",
                        confirmBtnColor: Colors.green,
                        cancelBtnTextStyle: TextStyle(color: Colors.red),
                        textColor: Theme.of(context).colorScheme.tertiary,
                        titleColor: Theme.of(context).colorScheme.tertiary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                      );
                    } else if (!_isFull && !_isRegistered) {
                      joinActivity();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _isRegistered
                          ? Colors.red
                          : _isFull
                              ? Colors.grey
                              : Theme.of(context).colorScheme.primary,
                      shape: StadiumBorder(),
                      elevation: 8),
                  child: Text(
                      _isRegistered
                          ? 'Leave Activity'
                          : _isFull
                              ? 'Activity Full'
                              : 'Join Activity',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubicle_fitness/models/user.dart';

class CompanyModel {
  final String? id;
  final String name;
  final String creatorId;
  final List<dynamic> members;
  final List<dynamic> activities;
  final int maxActivitiesPerWeek;
  final int activitiesPerWeekGoal;
  final String image;

  CompanyModel(
      {this.id,
      required this.name,
      required this.creatorId,
      required this.members,
      required this.activities,
      required this.image,
      required this.maxActivitiesPerWeek,
      required this.activitiesPerWeekGoal});

  toJson() {
    return {
      "name": name,
      "creatorId": creatorId,
      "maxActivitiesPerWeek": maxActivitiesPerWeek,
      "activitiesPerWeekGoal": activitiesPerWeekGoal,
      "members": members,
      "activities": activities,
      "image": image,
    };
  }

  factory CompanyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CompanyModel(
      id: document.id,
      name: data['name'] ?? '',
      creatorId: data['creatorId'] ?? '',
      image: data['image'] ?? '',
      members: data['members'],
      activities: data['activities'],
      maxActivitiesPerWeek: data['maxActivitiesPerWeek'],
      activitiesPerWeekGoal: data['activitiesPerWeekGoal'],
    );
  }
}

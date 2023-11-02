import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final String? id;
  final bool isParentActivity;
  final String? parentId;
  final String companyId;
  final String name;
  final String categoryId;
  final String description;
  final int cost;
  final String dateTime;
  final String repeated;
  final String location;
  final List<dynamic> participants;
  final int minParticipants;
  final int maxParticipants;

  ActivityModel({
    this.id,
    required this.isParentActivity,
    this.parentId,
    required this.companyId,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.cost,
    required this.dateTime,
    required this.repeated,
    required this.location,
    required this.participants,
    required this.minParticipants,
    required this.maxParticipants,
  });

  toJson() {
    return {
      "companyId": companyId,
      "isParentActivity": isParentActivity,
      "parentId": parentId,
      "name": name,
      "categoryId": categoryId,
      "description": description,
      "cost": cost,
      "dateTime": dateTime,
      "repeated": repeated,
      "location": location,
      "participants": participants,
      "minParticipants": minParticipants,
      "maxParticipants": maxParticipants
    };
  }

  factory ActivityModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ActivityModel(
      id: document.id,
      isParentActivity: data['isParentActivity'] ?? false,
      companyId: data['companyId'] ?? '',
      name: data['name'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      cost: data['cost'] ?? '',
      dateTime: data['dateTime'] ?? '',
      repeated: data['repeated'] ?? '',
      location: data['location'] ?? '',
      participants: data['participants'] ?? List.empty(),
      minParticipants: data['minParticipants'],
      maxParticipants: data['maxParticipants'],
    );
  }
}

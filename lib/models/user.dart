import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String surname;
  final String email;
  final String gender;
  final String dateOfBirth;
  String image;
  String? companyId;
  final List<String>? activities;
  List<dynamic> notifications;

  UserModel(
      {this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.gender,
      required this.dateOfBirth,
      required this.image,
      this.companyId,
      this.activities,
      required this.notifications});

  toJson() {
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "image": image,
      "companyId": companyId,
      "activities": activities,
      "notifications": notifications
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        name: data['name'] ?? '',
        surname: data['surname'] ?? '',
        email: data['email'] ?? '',
        gender: data['gender'] ?? 'Other',
        dateOfBirth: data['dateOfBirth'] ?? 'Undefined',
        image: data['image'] ?? '',
        companyId: data['companyId'],
        notifications: data['notifications'] ?? []);
  }
}

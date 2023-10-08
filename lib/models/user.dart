import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String surname;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String image;

  UserModel(
      {required this.name,
      required this.surname,
      required this.email,
      required this.gender,
      required this.dateOfBirth,
      required this.image});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "image": image
    };
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    return UserModel(
        name: data['name'],
        surname: data['surname'],
        email: data['email'],
        gender: data['gender'],
        dateOfBirth: data['dateOfBirth'],
        image: data['image']);
  }
}

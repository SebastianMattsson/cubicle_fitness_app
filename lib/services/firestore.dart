import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<void> addUser(String email, String name, String surname,
      String dateOfBirth, String gender, String image) {
    return users.add({
      'name': name,
      'surname': surname,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'image': image
    });
  }

  Future<void> addUserThroughGoogle(
      String? email, String? name, String? surname, String? image) {
    return users.add({
      'name': name,
      'surname': surname,
      'dateOfBirth': "Not defined",
      'gender': "Other",
      'email': email,
      'image': image
    });
  }

  Future<bool> checkUserExists(String? email) async {
    try {
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // If a document with the specified email is found, return true
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false; // Assume user doesn't exist in case of an error
    }
  }
}

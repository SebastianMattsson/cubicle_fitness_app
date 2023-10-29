import 'package:cloud_firestore/cloud_firestore.dart';

class JoinRequestModel {
  final String? id;
  final String companyId;
  final String userId;

  JoinRequestModel({this.id, required this.companyId, required this.userId});

  toJson() {
    return {"companyId": companyId, "userId": userId};
  }

  factory JoinRequestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return JoinRequestModel(
        id: document.id, companyId: data["companyId"], userId: data["userId"]);
  }
}

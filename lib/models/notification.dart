import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String notificationType;
  final String title;
  final String description;
  final String? senderId;
  bool isRead;
  final String receiverId;
  final Timestamp timestamp;

  NotificationModel(
      {this.id,
      required this.notificationType,
      required this.title,
      required this.description,
      required this.isRead,
      this.senderId,
      required this.receiverId,
      required this.timestamp});

  toJson() {
    return {
      "notificationType": notificationType,
      "title": title,
      "description": description,
      "isRead": isRead,
      "senderId": senderId,
      "receiverId": receiverId,
      "timestamp": timestamp
    };
  }

  factory NotificationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return NotificationModel(
        id: document.id,
        notificationType: data["notificationType"],
        title: data["title"],
        description: data["description"],
        isRead: data["isRead"],
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        timestamp: data["timestamp"]);
  }
}

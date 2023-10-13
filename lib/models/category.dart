import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubicle_fitness/models/user.dart';

class CategoryModel {
  final String? id;
  final String name;
  final String image;

  CategoryModel({this.id, required this.name, required this.image});

  toJson() {
    return {"name": name, "image": image};
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CategoryModel(
      id: document.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

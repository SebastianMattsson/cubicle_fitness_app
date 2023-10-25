// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/Activities/activity_widgets/category_tile.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});
  final db = FirestoreService();

  List<String> list = [
    "Yoga",
    "Padel",
    "Tennis",
    "Football",
    "Running",
    "Spinning",
    "Rugby",
    "Swimming"
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
        stream: db.getCategoryStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            var categoryData = snapshot.data!;
            categoryData.sort((a, b) => a.name.compareTo(b.name));
            return ListView.separated(
                itemBuilder: (context, index) => CategoryTile(
                      categoryData: categoryData[index],
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: categoryData.length);
          }
        });
  }
}

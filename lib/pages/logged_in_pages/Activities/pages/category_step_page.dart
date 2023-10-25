// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryStep extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final void Function(CategoryModel? selectedCategory) onCategorySelected;
  const CategoryStep(
      {super.key,
      required this.selectedCategory,
      required this.onCategorySelected});

  @override
  State<CategoryStep> createState() => _CategoryStepState();
}

class _CategoryStepState extends State<CategoryStep> {
  final _searchController = TextEditingController();
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return widget.selectedCategory == null
        ? Column(
            children: [
              Text(
                "Search for a Category",
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Theme.of(context).colorScheme.tertiary,
                    hintText: "Enter category name",
                    fillColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
              StreamBuilder<List<CategoryModel>>(
                  stream: db.getCategoryStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      var categoryData = snapshot.data!;
                      var filteredCategories = categoryData.where((category) {
                        // Check if the company name contains the search query
                        return category.name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase());
                      }).toList();
                      return Container(
                        height: 300,
                        child: ListView.separated(
                          itemCount: filteredCategories.length,
                          itemBuilder: (context, index) {
                            var category = filteredCategories[index];
                            bool isSelected = false;
                            if (widget.selectedCategory != null) {
                              isSelected = filteredCategories[index].name ==
                                  widget.selectedCategory!.name;
                            }

                            return ListTile(
                              onTap: () {
                                setState(() {
                                  widget.onCategorySelected(category);
                                });
                              },
                              title: Text(
                                filteredCategories[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      );
                    }
                  }),
            ],
          )
        : Column(
            children: [
              Text(
                "Search for a Category",
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.selectedCategory!.name,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onCategorySelected(widget.selectedCategory);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.4)),
                            height: 80,
                            width: 80,
                            child: Icon(
                              Icons.cancel,
                              size: 34,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
  }
}

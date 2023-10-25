import 'package:cubicle_fitness/models/category.dart';
import 'package:flutter/material.dart';

class HorizontalCategoryTile extends StatefulWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;
  const HorizontalCategoryTile(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onTap});

  @override
  State<HorizontalCategoryTile> createState() => _HorizontalCategoryTileState();
}

class _HorizontalCategoryTileState extends State<HorizontalCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(widget.category.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold)),
          )),
    );
  }
}

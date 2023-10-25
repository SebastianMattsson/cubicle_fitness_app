import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTile extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;
  const DateTile(
      {super.key,
      required this.date,
      required this.isSelected,
      required this.onTap});

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              widget.isSelected ? Theme.of(context).colorScheme.primary : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              DateFormat('d').format(widget.date),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(DateFormat('E').format(widget.date),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

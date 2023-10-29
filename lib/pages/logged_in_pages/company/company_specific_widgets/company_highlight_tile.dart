import 'package:flutter/material.dart';

class CompanyHighlightTile extends StatelessWidget {
  final String label;
  final String text;
  const CompanyHighlightTile(
      {super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(text,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}

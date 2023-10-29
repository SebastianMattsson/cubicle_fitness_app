import 'package:flutter/material.dart';

class CompanyContent extends StatelessWidget {
  final String label;
  final String text;
  final NetworkImage? image;

  const CompanyContent(
      {super.key, required this.label, required this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'Roboto',
                  fontSize: 22,
                )),
            SizedBox(
              height: 10,
            ),
            Text(text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                ))
          ],
        ),
      ),
    );
  }
}

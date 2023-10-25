import 'package:flutter/material.dart';

class ConfirmText extends StatelessWidget {
  final String text;
  final IconData icon;
  const ConfirmText({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

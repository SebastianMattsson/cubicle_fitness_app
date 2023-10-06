import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.showEndIcon = true,
      this.textColor});

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool showEndIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: textColor == null
                ? Theme.of(context).colorScheme.tertiary
                : textColor,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold),
      ),
      trailing: showEndIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Theme.of(context).colorScheme.background,
              ),
            )
          : null,
    );
  }
}

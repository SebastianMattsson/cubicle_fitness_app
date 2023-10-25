import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final String hintText;
  final Function()? onTap;
  final TextInputType? keyBoardType;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldForm(
      {super.key,
      required this.hintText,
      required this.label,
      required this.icon,
      required this.controller,
      this.onTap,
      this.validator,
      this.keyBoardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: keyBoardType,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIconColor: Theme.of(context).colorScheme.tertiary,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          prefixIcon: Icon(icon)),
    );
  }
}

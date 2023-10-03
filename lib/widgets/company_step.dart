import 'package:flutter/material.dart';

class CompanyStep extends StatelessWidget {
  const CompanyStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company Code",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ]),
            height: 60,
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              decoration: InputDecoration(
                  filled:
                      true, // Set to true to enable filling the container color
                  fillColor: Theme.of(context)
                      .colorScheme
                      .primary, // Background color of the TextField
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.qr_code_2_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  hintText: "Enter your companys code",
                  hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.6))),
            ),
          )
        ],
      ),
    );
  }
}

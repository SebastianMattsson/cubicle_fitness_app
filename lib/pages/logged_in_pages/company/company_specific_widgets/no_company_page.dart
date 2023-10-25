import 'package:cubicle_fitness/pages/logged_in_pages/company/pages/create_new_company_page.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/company/pages/search_company_page.dart';
import 'package:flutter/material.dart';

class NoCompanyPage extends StatelessWidget {
  const NoCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Your Company Fitness Hub!",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.tertiary),
          ),
          SizedBox(height: 20),
          Text(
            "Stay active and healthy during work hours by joining your company's fitness program. Currently, you are not part of any company.",
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
          ),
          SizedBox(height: 40),
          Center(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNewCompanyPage())),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: StadiumBorder(),
                    elevation: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Create a New Company",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchForCompanyPage())),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: StadiumBorder(),
                    elevation: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Join an Existing Company",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

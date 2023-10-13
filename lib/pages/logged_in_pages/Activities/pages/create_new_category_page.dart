import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateCategoryPage extends StatelessWidget {
  CreateCategoryPage({super.key});

  final TextEditingController requestController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Request New Category",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontFamily: 'Roboto',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Can't find the category you're looking for? Request it below, and the admin will consider adding it!",
                style: TextStyle(
                  fontSize: 16,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: requestController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Category Request",
                  hintText: "Enter your category request here",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle category request logic here
                      // You can use requestController.text to get the user's request.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: StadiumBorder(),
                      elevation: 10,
                    ),
                    child: Text(
                      "Submit Request",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

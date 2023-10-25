// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchForCompanyPage extends StatefulWidget {
  SearchForCompanyPage({super.key});

  @override
  State<SearchForCompanyPage> createState() => _SearchForCompanyPageState();
}

class _SearchForCompanyPageState extends State<SearchForCompanyPage> {
  final db = FirestoreService();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _searchController = TextEditingController();

  void joinCompany(CompanyModel company) async {
    var user = await db.getUserData(currentUser.email);

    if (user != null) {
      await db.joinCompany(user, company);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text(
          "Join Company",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a company",
              style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Theme.of(context).colorScheme.tertiary,
                  hintText: "Enter company name",
                  fillColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none)),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: db.getCompaniesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      var companiesData = snapshot.data!;
                      var filteredCompanies = companiesData.where((company) {
                        // Check if the company name contains the search query
                        return company.name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase());
                      }).toList();
                      return ListView.builder(
                          itemCount: filteredCompanies.length,
                          itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  filteredCompanies[index].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                subtitle: Text(
                                  "Members: ${filteredCompanies[index].members.length}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                ),
                                leading: Image(
                                    width: 60,
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("lib/images/company.jpg")),
                                trailing: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        shape: StadiumBorder(),
                                        elevation: 6),
                                    onPressed: () =>
                                        joinCompany(filteredCompanies[index]),
                                    child: Text(
                                      "Join",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                    )),
                              ));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

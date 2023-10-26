import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubicle_fitness/models/activity.dart';
import 'package:cubicle_fitness/models/category.dart';
import 'package:cubicle_fitness/models/company.dart';
import 'package:cubicle_fitness/models/user.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference companies =
      FirebaseFirestore.instance.collection("companies");

  final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  final CollectionReference activities =
      FirebaseFirestore.instance.collection("activities");

  Stream<UserModel> getUserStreamByEmail(String email) {
    var userRef = users.where('email', isEqualTo: email);

    return userRef.snapshots().map(
      (querySnapshot) {
        var userData = querySnapshot
            .docs.first; // Assuming there's only one user with a specific email
        return UserModel.fromSnapshot(
            userData as DocumentSnapshot<Map<String, dynamic>>);
      },
    );
  }

  Stream<UserModel> getUserStreamById(String id) {
    var userRef = users.doc(id);

    return userRef.snapshots().map((documentSnapshot) {
      return UserModel.fromSnapshot(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Stream<CompanyModel> getCompanyStreamForUser(String email) {
    return getUserStreamByEmail(email).asyncExpand((user) {
      if (user.companyId != null) {
        return companies.doc(user.companyId).snapshots().map(
              (company) => CompanyModel.fromSnapshot(
                  company as DocumentSnapshot<Map<String, dynamic>>),
            );
      } else {
        // If companyId is null, return an empty stream
        return const Stream.empty();
      }
    });
  }

  Stream<CompanyModel> getCompanyStream(String id) {
    var companyRef = companies.doc(id);

    return companyRef.snapshots().map((documentSnapshot) {
      return CompanyModel.fromSnapshot(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Stream<List<UserModel>> getMembersInCompanyStream(String companyId) {
    return users.where('companyId', isEqualTo: companyId).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => UserModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Stream<List<CompanyModel>> getCompaniesStream() {
    return companies.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return CompanyModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  Stream<List<ActivityModel>> getCompaniesActivitiesStream(String companyId) {
    return activities.where('companyId', isEqualTo: companyId).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ActivityModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Stream<List<CategoryModel>> getCategoryStream() {
    return categories.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return CategoryModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  Stream<List<ActivityModel>> getActivitiesWhereIsParentActivityStream(
      String companyId) {
    return activities
        .where('companyId', isEqualTo: companyId)
        .where('isParentActivity', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => ActivityModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> returnCategories = [];

    try {
      QuerySnapshot categorySnapshot = await categories.get();

      for (var doc in categorySnapshot.docs) {
        returnCategories.add(CategoryModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>));
      }
      return returnCategories;
    } catch (e) {
      return []; // Return an empty list in case of error
    }
  }

  Future<void> joinCompany(UserModel user, CompanyModel company) async {
    try {
      // Update user data in Firestore
      user.companyId = company.id;
      company.members.add(user.id);
      await updateUser(user);
      await updateCompany(company);
    } catch (e) {}
  }

  Future<void> leaveCompany(UserModel user, CompanyModel company) async {
    try {
      // Update user data in Firestore
      user.companyId = null;
      company.members.remove(user.id);
      await updateUser(user);
      await updateCompany(company);
    } catch (e) {}
  }

  Future<void> deleteCompany(CompanyModel company, UserModel user) async {
    // Set companyId to null for all members
    for (var memberId in company.members) {
      await users.doc(memberId).update({"companyId": null});
    }

    // Delete the company
    await companies.doc(company.id).delete();
  }

  Future<void> deleteActivity(ActivityModel activity) async {
    //Find activities with matching parentId
    var activitiesToDelete =
        await activities.where('parentId', isEqualTo: activity.id).get();

    // Delete each activity
    for (var doc in activitiesToDelete.docs) {
      await doc.reference.delete();
    }
    await activities.doc(activity.id).delete();
  }

  Future<UserModel?> getUserData(String? email) async {
    final snapshot = await users.where("email", isEqualTo: email).get();
    final userData = snapshot.docs
        .map((e) =>
            UserModel.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>))
        .single;
    return userData;
  }

  Future<void> createNewCompany(String companyName, int maxWorkouts,
      int weeklyGoal, UserModel user) async {
    String companyId = companies.doc().id;

    // Create a new company instance
    CompanyModel newCompany = CompanyModel(
      id: companyId,
      name: companyName,
      creatorId: user.id!,
      members: [user.id!],
      activities: List.empty(),
      maxActivitiesPerWeek: maxWorkouts,
      activitiesPerWeekGoal: weeklyGoal,
      image: '', // Provide image URL if applicable
    );
    user.companyId = companyId;

    // Create a new document for the company in Firestore
    await companies.doc(companyId).set(newCompany.toJson());
    await updateUser(user);
  }

  Future<String> createNewActivity(ActivityModel activity) async {
    DocumentReference docRef = await activities.add(activity.toJson());

    // Return the ID of the created activity
    return docRef.id;
  }

  Future<void> addUser(UserModel newUser) {
    return users.add(newUser.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await users.doc(user.id).update(user.toJson());
  }

  Future<void> updateCompany(CompanyModel company) async {
    await companies.doc(company.id).update(company.toJson());
  }

  Future<void> updateActivity(ActivityModel activity) async {
    await activities.doc(activity.id).update(activity.toJson());
  }

  Future<void> addUserThroughGoogle(
      String? email, String? name, String? surname, String? image) {
    return users.add({
      'name': name,
      'surname': surname,
      'dateOfBirth': "Not defined",
      'gender': "Other",
      'email': email,
      'image': image
    });
  }

  Future<bool> checkUserExists(String? email) async {
    try {
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // If a document with the specified email is found, return true
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false; // Assume user doesn't exist in case of an error
    }
  }
}

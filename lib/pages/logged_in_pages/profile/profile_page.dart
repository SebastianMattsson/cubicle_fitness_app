// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:io';

import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/pages/logged_in_pages/profile/edit_profile_page.dart';
import 'package:cubicle_fitness/services/auth_service.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:cubicle_fitness/widgets/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirestoreService();
  final _auth = AuthService();

  Future pickImage(ImageSource source, UserModel user) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source, imageQuality: 20);

    if (file == null) {
      return;
    }

    var croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

    if (croppedFile == null) {
      return;
    }

    var compressedFile = await compressImage(croppedFile.path, 5);

    var fileUrl = await uploadImage(compressedFile!.path);

    user.image = fileUrl;

    await db.updateUser(user);
  }

  Future<XFile?> compressImage(String path, int imageQuality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        "${DateTime.now()}.${p.extension(path)}");
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: imageQuality);

    return result;
  }

  Future<String> uploadImage(String path) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child("${DateTime.now().toIso8601String() + p.basename(path)}");

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    return fileUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: StreamBuilder<UserModel?>(
              stream: db.getUserStreamByEmail(currentUser.email!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data;
                  return Column(children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(userData!.image)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) => BottomSheet(
                                      onClosing: () {},
                                      builder: (context) => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 10,
                                                right: 10,
                                                bottom: 30),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.camera),
                                                  title: Text("Camera"),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    pickImage(
                                                        ImageSource.camera,
                                                        userData);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.image),
                                                  title: Text("Gallery"),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    pickImage(
                                                        ImageSource.gallery,
                                                        userData);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )));
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary),
                              child: Icon(Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${userData.name} ${userData.surname}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 25,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfilePage())),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: StadiumBorder(),
                            elevation: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileMenuItem(
                      title: "Settings",
                      icon: Icons.settings,
                      onPress: () {},
                    ),
                    ProfileMenuItem(
                      title: "Billing Details",
                      icon: Icons.wallet,
                      onPress: () {},
                    ),
                    ProfileMenuItem(
                      title: "User Management",
                      icon: Icons.lock_person_rounded,
                      onPress: () {},
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProfileMenuItem(
                      title: "Information",
                      icon: Icons.info_outline,
                      onPress: () {},
                    ),
                    ProfileMenuItem(
                      title: "Logout",
                      icon: Icons.logout,
                      onPress: () async {
                        await _auth.signOut();
                      },
                      textColor: Colors.red,
                      showEndIcon: false,
                    ),
                  ]);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

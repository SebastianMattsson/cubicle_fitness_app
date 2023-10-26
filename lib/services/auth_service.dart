import 'package:cubicle_fitness/models/user.dart';
import 'package:cubicle_fitness/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirestoreService();

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {}
  }

  Future createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String surname,
      String dateOfBirth,
      String gender,
      String image) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //_firestore.addUser(email, name, surname, dateOfBirth, gender, image);
      var newUser = UserModel(
          name: name,
          surname: surname,
          email: email,
          gender: gender,
          dateOfBirth: dateOfBirth,
          image: image);
      _firestore.addUser(newUser);
      return userCredential;
    } catch (e) {}
  }

//Google sign in
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        return null;
      }
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user document already exists
      bool userExists =
          await _firestore.checkUserExists(userCredential.user!.email);

      List<String>? nameParts = userCredential.user!.displayName!.split(' ');
      String name = nameParts[0];
      String surname = nameParts.length > 1 ? nameParts[1] : '';

      // If the user document does not exist, add it
      if (!userExists) {
        _firestore.addUserThroughGoogle(userCredential.user!.email, name,
            surname, userCredential.user!.photoURL);
      }
      return userCredential;
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}

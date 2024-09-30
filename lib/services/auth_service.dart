import 'package:logger/logger.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  // ignore: prefer_final_fields
  var _logger = Logger();

  /*
  * Logs in a user with email and password, returning the [User] object on success.
  * Returns null if the login fails.
  * */
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      _logger.e("Something went wrong in loginUserWithEmailAndPassword : $e");
    }
    return null;
  }

  /*
  * Signs in a user with Google and returns the [User] object on success.
  * Returns null if the login fails.
  **/
  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    } catch (e) {
      _logger.e(e.toString());
    }
    return null;
  }

  /*
  * Sign out from email and password login or from GoogleSignIn
  * */
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      _logger.e("Something went wrong in sign out");
    }
  }
}

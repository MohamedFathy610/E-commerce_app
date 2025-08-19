import 'package:firebase_auth/firebase_auth.dart';
class GoogleAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential = await _auth.signInWithPopup(googleProvider);

      // This token can be used to access the user's information
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signUpWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } catch (error) {
    print("uh oh");
    throw error;
  }
}

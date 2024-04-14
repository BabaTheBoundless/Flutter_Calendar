import 'package:firebase_auth/firebase_auth.dart';

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (error) {
    print("uh oh but with signout this time");
    throw error;
  }
}

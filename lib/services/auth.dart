import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  ///Regiter User
  Future<User> regiterUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      return userCredential.user!;
    } catch (e) {
      throw e.toString();
    }
  }

  ///Login
  Future<User> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      throw e.toString();
    }
  }

  ///Reset Password
  Future resetPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

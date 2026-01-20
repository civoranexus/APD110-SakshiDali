import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Current logged-in user
  User? get currentUser => _auth.currentUser;

  /// ================= LOGIN =================
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      _showMessage(context, "Login successful");
    } on FirebaseAuthException catch (e) {
      _showMessage(context, e.message ?? "Login failed");
    } catch (e) {
      _showMessage(context, "Something went wrong");
    }
  }

  /// ================= SIGNUP =================
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      /// Send email verification
      await userCredential.user?.sendEmailVerification();

      _showMessage(
        context,
        "Account created. Verification email sent.",
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(context, e.message ?? "Signup failed");
    } catch (e) {
      _showMessage(context, "Something went wrong");
    }
  }

  /// ================= LOGOUT =================
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// ================= FORGOT PASSWORD =================
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      _showMessage(context, "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      _showMessage(context, e.message ?? "Failed to send email");
    }
  }

  /// ================= AUTH STATE =================
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  /// ================= HELPER =================
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

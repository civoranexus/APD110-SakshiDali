import 'package:apd110_sakshidali/features/auth/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= SIGN UP =================
  Future<void> signup({
    required String name,
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

      User user = userCredential.user!;

      // 🔹 Save name in FirebaseAuth
      await user.updateDisplayName(name);
      await user.reload();

      // 🔹 Save user in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'isEmailVerified': user.emailVerified,
      });

      // 🔹 Send verification email
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Signup successful. Please verify your email before login.",
          ),
        ),
      );

      // 🔹 Go back to Login page
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    }
  }

  // ================= LOGIN =================
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User user = userCredential.user!;

      // 🔥 VERY IMPORTANT
      await user.reload();
      user = _auth.currentUser!;

      // // ❌ Block login if email not verified
      // if (!user.emailVerified) {
      //   await user.sendEmailVerification();
      //   await _auth.signOut();

      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //         "Email not verified. Verification link sent again.",
      //       ),
      //     ),
      //   );
      //   return;
      // }

      // ✅ Login success → HomePage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  // ================= LOGOUT =================
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

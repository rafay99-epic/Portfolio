// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'package:flutter/material.dart';

import 'package:rafay_portfolio/admin/frontend/pages/auth/opt.dart';
import 'package:rafay_portfolio/admin/frontend/pages/dashboardPage.dart';
import 'package:rafay_portfolio/user/frontend/widgets/dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> handleLogin(BuildContext context, String email, String password,
      String phoneNumber) async {
    try {
      UserCredential? userCredential =
          await signInWithEmailAndPassword(email, password);

      // If the user is authenticated, start the phone number verification process
      if (userCredential != null && userCredential.user != null) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // This callback will be called if the verification is done automatically
            await FirebaseAuth.instance.signInWithCredential(credential);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            // Handle the error
          },
          codeSent: (String verificationId, int? resendToken) {
            // This callback will be called if the user needs to manually enter the OTP
            // Navigate to a new page where the user can enter the OTP
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(
                  verificationId: verificationId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            showDialogBox(
              context,
              Icons.error,
              Colors.red,
              Colors.red,
              'Error',
              'Sorry OTP Expired',
              () => Navigator.of(context).pop(),
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  //logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

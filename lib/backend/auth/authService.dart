// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/admin/pages/auth/otp_email.dart';
import 'package:rafay_portfolio/constants/widgets/dialogBox/dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_otp/email_otp.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();
  Future<UserCredential?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      showDialogBox(
        context,
        Icons.error,
        Colors.red,
        Colors.red,
        'Error',
        e.message ?? 'An error occurred.',
        () => Navigator.of(context).pop(),
      );
      return null;
    }
  }

  Future<void> handleLogin(BuildContext context, String email, String password,
      String phoneNumber) async {
    UserCredential? userCredential =
        await signInWithEmailAndPassword(context, email, password);

    // If the user is authenticated, start the phone number verification process
    if (userCredential != null && userCredential.user != null) {
      myauth.setConfig(
          appEmail: "99marafay@gmail.com",
          appName: "Admin",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);

      var template =
          'Hi {{app_name}} Your OTP Code For Admin Dashboard is {{otp}}.';
      myauth.setTemplate(render: template);
      if (await myauth.sendOTP() == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent"),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpEmailVerifyScreen(
                      myauth: myauth,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Oops, OTP send failed"),
        ));
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

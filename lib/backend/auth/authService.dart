// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/admin/pages/auth/opt.dart';
import 'package:rafay_portfolio/frontend/admin/pages/auth/otp_email.dart';
import 'package:rafay_portfolio/frontend/admin/pages/dashboardPage.dart';
import 'package:rafay_portfolio/constants/widgets/dialogBox/dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

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
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const DashboardPage(),
      //       ),
      //     );
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     showDialogBox(
      //       context,
      //       Icons.error,
      //       Colors.red,
      //       Colors.red,
      //       'Error',
      //       e.message ?? 'An error occurred.',
      //       () => Navigator.of(context).pop(),
      //     );
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => OtpPage(
      //           verificationId: verificationId,
      //         ),
      //       ),
      //     );
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {
      //     showDialogBox(
      //       context,
      //       Icons.error,
      //       Colors.red,
      //       Colors.red,
      //       'Error',
      //       'Sorry OTP Expired',
      //       () => Navigator.of(context).pop(),
      //     );
      //   },
      // );

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

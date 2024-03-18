// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rafay_portfolio/admin/frontend/pages/dashboardPage.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/user/frontend/widgets/dialogbox.dart';
import 'package:rafay_portfolio/user/frontend/widgets/snackBar.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;

  const OtpPage({super.key, required this.verificationId});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Verify OTP
    Future<void> verifyOtp() async {
      // Create a PhoneAuthCredential with the verification ID and the OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text,
      );
      try {
        // Sign in with the credential
        await FirebaseAuth.instance.signInWithCredential(credential);

        // SnackBar to show the OTP is verified
        const SnackBarWidget(
          text: 'OTP Pin is verified !',
        );
        // If the OTP is verified, navigate to DashboardPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 55.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AnimatedTextBuilder(
                      text: "OTP Login",
                      size: 70.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CustomTextField(
                      labelText: 'OTP Pin',
                      controller: _otpController,
                      maxLines: 1,
                      hintText: 'Enter your OTP PIN',
                      prefixIcon: Icons.pin,
                      passwordText: true,
                      peekpassword: true,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        //Check if email and password are not empty
                        if (_otpController.text.isEmpty) {
                          showDialogBox(
                            context,
                            Icons.error,
                            Colors.red,
                            Colors.red,
                            'Error',
                            'Enter the OTP password.',
                            () => Navigator.of(context).pop(),
                          );
                          return;
                        }

                        //firebase Login and Error Handelling
                        verifyOtp();

                        //clear text Feild
                        _otpController.clear();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.all(20.0),
                      ),
                      label: const Text("Verify OTP Pin"),
                      icon: const Icon(Icons.verified_user_sharp),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Lottie.asset(
                  'assets/animation/otp.json',
                  width: 10000,
                  height: 10000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

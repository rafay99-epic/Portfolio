import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafay_portfolio/admin/backend/auth/authService.dart';
import 'package:rafay_portfolio/admin/frontend/pages/dashboardPage.dart';

import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
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
                      text: "Admin Login",
                      size: 70.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CustomTextField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email,
                      controller: widget.emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      labelText: 'Password',
                      controller: widget.passwordController,
                      maxLines: 1,
                      hintText: 'Enter your password',
                      prefixIcon: Icons.password,
                      passwordText: true,
                      peekpassword: true,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        //Check if email and password are not empty
                        if (widget.emailController.text.isEmpty ||
                            widget.passwordController.text.isEmpty) {
                          showEmptyFieldsDialog(context);
                          return;
                        }

                        //firebase Login and Error Handelling
                        await handleLogin(context);

                        //making sure to clear the controller
                        widget.emailController.clear();
                        widget.passwordController.clear();
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
                      label: const Text("Login"),
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Lottie.asset(
                  'assets/animation/admin.json',
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

  //Login Function
  Future<void> handleLogin(BuildContext context) async {
    try {
      UserCredential? userCredential =
          await widget._authService.signInWithEmailAndPassword(
        widget.emailController.text,
        widget.passwordController.text,
      );

      // If the user is authenticated, navigate to the next screen
      if (userCredential != null && userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'auth/user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'auth/wrong-password':
            errorMessage = 'Wrong password provided for that user.';
            break;
          case 'auth/invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'auth/invalid-credential':
            errorMessage = 'The credential data is malformed or has expired.';
            break;
          default:
            errorMessage = 'An unknown error occurred.';
            break;
        }
      } else {
        errorMessage = 'An error occurred.';
      }

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const StyledText(
              text: 'Login Error',
              fontSize: 14,
            ),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: const StyledText(
                  text: 'OK',
                  fontSize: 14,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog box
                },
              ),
            ],
          );
        },
      );
    }
  }

  //Empty Fields Dialog
  void showEmptyFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StyledText(
            text: 'Error',
            fontSize: 22,
            bold: true,
          ),
          content: const StyledText(
            text: 'Please enter your email and password.',
            fontSize: 20,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog box
              },
            ),
          ],
        );
      },
    );
  }
}

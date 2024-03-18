// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/admin/backend/auth/authService.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/user/frontend/widgets/dialogbox.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var phoneNumber = '+92 3035650798';
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
                          // showEmptyFieldsDialog(context);
                          showDialogBox(
                            context,
                            Icons.error,
                            Colors.red,
                            Theme.of(context).colorScheme.primary,
                            'Error',
                            'Please enter your email and password.',
                            () => Navigator.of(context).pop(),
                          );
                          return;
                        }

                        //firebase Login and Error Handelling

                        await widget._authService.handleLogin(
                            context,
                            widget.emailController.text,
                            widget.passwordController.text,
                            widget.phoneNumber);

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
}

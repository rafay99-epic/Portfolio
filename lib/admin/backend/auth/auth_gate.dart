import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/admin/frontend/pages/dashboardPage.dart';
import 'package:rafay_portfolio/admin/frontend/pages/auth/loginPage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const DashboardPage();
          } else {
            return const LoginAdmin();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rafay_portfolio/admin/backend/auth/authService.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Do you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog box
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        Navigator.of(context).pop(); // Close the dialog box
                        await _authService
                            .signOut(); //logouting out from firebase
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed(
                            '/admin'); // Redirect to the login page
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

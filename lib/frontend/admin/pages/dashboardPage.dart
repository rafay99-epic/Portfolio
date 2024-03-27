import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/admin/view/dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Dashboard(),
    );
  }
}

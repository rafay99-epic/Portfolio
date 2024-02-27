import 'package:flutter/material.dart';

import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}

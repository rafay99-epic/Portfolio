import 'package:flutter/material.dart';

import 'package:rafay_portfolio/constants/widgets/ultis/responsive.dart';
import 'package:rafay_portfolio/frontend/user/pages/home/widgets/web/ConnectButton.dart';
import 'package:rafay_portfolio/frontend/user/pages/home/widgets/web/NavigationButtonList.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/image/favicon.png',
              )),
          const Spacer(
            flex: 2,
          ),
          if (!Responsive.isLargeMobile(context)) const NavigationButtonList(),
          const Spacer(
            flex: 2,
          ),
          const ConnectButton(),
          const Spacer(),
        ],
      ),
    );
  }
}

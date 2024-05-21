import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/values/const_values.dart';
import 'package:rafay_portfolio/frontend/user/pages/home/widgets/web/NavigationButtonList.dart';

import 'package:rafay_portfolio/frontend/user/pages/home/widgets/web/TopNavigationBar.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/responsive.dart';

class MenuSwitcher extends StatelessWidget {
  const MenuSwitcher({super.key, required this.pages});
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            kIsWeb && !Responsive.isLargeMobile(context)
                ? const SizedBox(
                    height: defaultPadding,
                  )
                : const SizedBox(
                    height: defaultPadding / 2,
                  ),
            const SizedBox(
              height: 80,
              child: TopNavigationBar(),
            ),
            if (Responsive.isLargeMobile(context))
              const Row(
                children: [Spacer(), NavigationButtonList(), Spacer()],
              ),
            Expanded(
              flex: 9,
              child: PageView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [...pages],
              ),
            )
          ],
        ),
      ),
    );
  }
}

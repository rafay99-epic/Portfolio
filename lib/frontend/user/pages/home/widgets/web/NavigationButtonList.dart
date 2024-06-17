import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/values/const_values.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/responsive.dart';
import 'package:rafay_portfolio/frontend/user/pages/home/widgets/web/NavigationTextButton.dart';

class NavigationButtonList extends StatelessWidget {
  const NavigationButtonList({super.key});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.25),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Row(
            children: [
              NavigationTextButton(
                  onTap: () {
                    controller.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  text: 'Home'),
              NavigationTextButton(
                  onTap: () {
                    controller.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  text: 'About me'),
              NavigationTextButton(
                  onTap: () {
                    controller.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  text: 'Projects'),
              NavigationTextButton(
                  onTap: () {
                    controller.animateToPage(3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  text: 'Experiences'),
              Visibility(
                visible: !Responsive.isMobile(context),
                child: NavigationTextButton(
                    onTap: () {
                      controller.animateToPage(4,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    text: 'Blogs'),
              ),
            ],
          ),
        );
      },
    );
  }
}

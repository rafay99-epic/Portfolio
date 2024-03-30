import 'package:flutter/material.dart';

mixin ScrollControllerMixin {
  ScrollController scrollController = ScrollController();

  void initState() {
    scrollController = ScrollController();
  }

  void dispose() {
    scrollController.dispose();
  }

  // Scroll Down
  void smoothScrollDown() {
    scrollController.animateTo(
      scrollController.offset + 300,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  //Scroll Top
  void smoothScrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

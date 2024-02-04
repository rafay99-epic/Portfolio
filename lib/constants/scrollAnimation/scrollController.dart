import 'package:flutter/material.dart';

class SmoothScrollController extends StatefulWidget {
  final Widget child;

  const SmoothScrollController({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _SmoothScrollControllerState createState() => _SmoothScrollControllerState();
}

class _SmoothScrollControllerState extends State<SmoothScrollController> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void smoothScrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: widget.child,
    );
  }
}

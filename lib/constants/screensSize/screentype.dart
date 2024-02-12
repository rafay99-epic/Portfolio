class ScreenType {
  final double width;

  ScreenType(this.width);

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1200;
  bool get isDesktop => width >= 1200;
}

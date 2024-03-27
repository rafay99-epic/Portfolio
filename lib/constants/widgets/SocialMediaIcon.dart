// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color color;
  final double? iconSize;

  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.url,
    this.color = Colors.black,
    this.iconSize,
  });

  Future<void> launchUrlString(String urlString) async {
    if (await canLaunch(urlString)) {
      try {
        await launch(
          urlString,
          forceSafariVC: true,
          forceWebView: true,
          universalLinksOnly: true,
        );
      } catch (e) {
        print('Could not launch $urlString. Exception: $e');
      }
    } else {
      print('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      iconSize: iconSize,
      icon: FaIcon(icon),
      onPressed: () => launchUrlString(url),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/SocialMediaIcon.dart';

Widget buildSocialMediaRow(String url, context) {
  return Row(
    children: <Widget>[
      SocialMediaButton(
        icon: FontAwesomeIcons.facebook,
        url:
            'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent('https://rafay99.com/blog/$url')}',
        color: Theme.of(context).colorScheme.primary,
      ),
      SocialMediaButton(
        icon: FontAwesomeIcons.twitter,
        url:
            'https://twitter.com/intent/tweet?text=${Uri.encodeComponent('Check out this blog post:')}%20${Uri.encodeComponent('https://rafay99.com/blog/$url')}',
        color: Theme.of(context).colorScheme.primary,
      ),
      SocialMediaButton(
        icon: FontAwesomeIcons.linkedin,
        url:
            'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent('https://rafay99.com/blog/$url')}',
        color: Theme.of(context).colorScheme.primary,
      ),
    ],
  );
}

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/values/const_values.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse('https://wa.me/03035650798'));
        },
        borderRadius: BorderRadius.circular(defaultPadding + 10),
        child: Container(
          height: 60,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  offset: const Offset(0, -1),
                  blurRadius: 0),
              BoxShadow(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  offset: const Offset(0, 1),
                  blurRadius: 0),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.whatsapp,
                color: Theme.of(context).colorScheme.background,
                size: 15,
              ),
              const SizedBox(width: defaultPadding / 4),
              Text(
                'Whatsapp',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/HoverChip.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/SocialMediaIcon.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String githubLink;
  final String deployedLink;
  final double cardHeight;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.githubLink,
    required this.deployedLink,
    this.cardHeight = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildRichText('Project: ', title, context),
                  const SizedBox(height: 10),
                  buildRichText('Description: ', description, context),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: technologies
                        .map((tech) => HoverChip(label: tech))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  StyledText(
                    text: "Project Deployed & Location",
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.primary,
                    bold: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SocialMediaButton(
                        icon: FontAwesomeIcons.link,
                        url: deployedLink,
                        iconSize: 25.0,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.github,
                        url: githubLink,
                        iconSize: 25.0,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRichText(String label, String value, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: label,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: "roboto",
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafay_portfolio/user/frontend/widgets/SocialMediaIcon.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class ProjectCard extends StatefulWidget {
  final String text;
  final double HeadingFontSize;
  final double DescriptionFontSize;
  final String description;

  final String deploedlink;
  final String githublink;
  final List<String> technologyNames;

  const ProjectCard({
    super.key,
    required this.text,
    required this.HeadingFontSize,
    required this.DescriptionFontSize,
    required this.description,
    required this.deploedlink,
    required this.githublink,
    required this.technologyNames,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    double headingFontSize =
        isMobile ? widget.HeadingFontSize * 0.8 : widget.HeadingFontSize;
    double descriptionFontSize = isMobile
        ? widget.DescriptionFontSize * 0.8
        : widget.DescriptionFontSize;
    EdgeInsets padding = isMobile
        ? const EdgeInsets.all(5.0)
        : const EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0, left: 10.0);
    double spaceHeight = isMobile ? 10.0 : 25.0;

    return MouseRegion(
      onHover: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: Card(
        margin: const EdgeInsets.only(top: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: _isHovering ? 10 : 5,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.folder,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 30,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SocialMediaButton(
                          icon: FontAwesomeIcons.link,
                          url: widget.deploedlink,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.github,
                          url: widget.githublink,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: spaceHeight,
              ),
              StyledText(
                text: widget.text,
                fontSize: headingFontSize,
                bold: true,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              StyledText(
                text: widget.description,
                fontSize: descriptionFontSize,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.technologyNames
                    .expand((name) => [
                          Text(
                            name,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ])
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

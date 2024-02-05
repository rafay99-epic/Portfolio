// ignore_for_file: non_constant_identifier_names
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

//  hower Effect is working
class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: Card(
        margin: const EdgeInsets.only(top: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: _isHovering ? 10 : 5,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                  top: 5.0,
                  bottom: 5.0,
                  left: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              SocialMediaButton(
                                icon: FontAwesomeIcons.github,
                                url: widget.githublink,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    StyledText(
                      text: widget.text,
                      fontSize: widget.HeadingFontSize,
                      bold: true,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    StyledText(
                      text: widget.description,
                      fontSize: widget.DescriptionFontSize,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
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
                                ), // Add space between each string
                              ])
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Orginal Code

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     elevation: 5,
  //     child: Column(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Image.asset(widget.assetImage, fit: BoxFit.cover),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Text(
  //                   widget.text,
  //                   style: TextStyle(
  //                     fontSize: widget.HeadingFontSize,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Text(
  //                   widget.description,
  //                   style: TextStyle(
  //                     fontSize: widget.DescriptionFontSize,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
// }

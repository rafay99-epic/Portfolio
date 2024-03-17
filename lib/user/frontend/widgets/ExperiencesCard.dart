// // ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/user/frontend/class/jobExperienceData.dart';
import 'package:rafay_portfolio/user/frontend/views/ProjectGallery.dart';
import 'package:rafay_portfolio/user/frontend/widgets/HoverChip.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

// class ExperienceCard extends StatefulWidget {
//   final String companyName;
//   final String position;
//   final String employmentTime;
//   final List<String> toolsUsed;
//   final List<String> jobRole;

//   const ExperienceCard({
//     super.key,
//     required this.companyName,
//     required this.position,
//     required this.employmentTime,
//     required this.toolsUsed,
//     required this.jobRole,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _ExperienceCardState createState() => _ExperienceCardState();
// }

// class _ExperienceCardState extends State<ExperienceCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             StyledText(
//                               text: widget.companyName,
//                               fontSize: 30,
//                               bold: true,
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             StyledText(
//                               text: "@${widget.position}",
//                               fontSize: 18,
//                               color:
//                                   Theme.of(context).colorScheme.inversePrimary,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Icon(
//                           FontAwesomeIcons.clock,
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         StyledText(
//                           text: widget.employmentTime,
//                           fontSize: 16,
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     StyledText(
//                       text: "Responsibilities",
//                       fontSize: 22,
//                       bold: true,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: widget.jobRole.map((role) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.arrow_right,
//                                 size: 30,
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .inversePrimary,
//                               ),
//                               Expanded(
//                                 child: StyledText(
//                                   text: role,
//                                   fontSize: 18,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     StyledText(
//                       text: "Technology Used",
//                       fontSize: 22,
//                       bold: true,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: widget.toolsUsed.map((tool) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.arrow_right,
//                                 size: 30,
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .inversePrimary,
//                               ),
//                               Expanded(
//                                 child: StyledText(
//                                   text: tool,
//                                   fontSize: 18,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//card Widget
class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
          minHeight: screenType.isMobile ? 600 : 400,
        ),
        height: 350,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                screenType.isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StyledText(
                            text: job.companyName,
                            fontSize: 22,
                            bold: true,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StyledText(
                            text: "@ ${job.position}",
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          StyledText(
                            text: job.companyName,
                            fontSize: 30,
                            bold: true,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          StyledText(
                            text: "@${job.position}",
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    StyledText(
                      text: job.employmentTime,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                StyledText(
                  text: "Responsibilities",
                  fontSize: 22,
                  bold: true,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: job.roles.map((role) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_right,
                            size: 30,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          Expanded(
                            child: StyledText(
                              text: role,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                StyledText(
                  text: "Technology Used",
                  fontSize: 22,
                  bold: true,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List<Widget>.generate(
                    job.toolsUsed.length,
                    (int index) {
                      return Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 40),
                        child: HoverChip(label: job.toolsUsed[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

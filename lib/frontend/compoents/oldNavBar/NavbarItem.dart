// // navbar_item.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // import the Google Fonts package

// class NavBarItem extends StatefulWidget {
//   final String title;
//   final IconData icons;
//   final String routeName;

//   const NavBarItem(this.title,
//       {Key? key, required this.icons, required this.routeName})
//       : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _NavBarItemState createState() => _NavBarItemState();
// }

// class _NavBarItemState extends State<NavBarItem> {
//   bool _isHovering = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           widget.routeName,
//         );
//       },
//       child: MouseRegion(
//         onEnter: (event) => setState(() => _isHovering = true),
//         onExit: (event) => setState(() => _isHovering = false),
//         child: Padding(
//           padding: const EdgeInsets.only(
//             right: 18.0,
//           ),
//           child: Row(
//             children: <Widget>[
//               Icon(
//                 widget.icons,
//                 color: _isHovering
//                     ? Theme.of(context).colorScheme.inversePrimary
//                     : Theme.of(context).colorScheme.primary,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 widget.title,
//                 style: GoogleFonts.roboto(
//                   color: _isHovering
//                       ? Theme.of(context).colorScheme.inversePrimary
//                       : Theme.of(context).colorScheme.primary,
//                   fontSize: 18,
//                   decoration: _isHovering
//                       ? TextDecoration.underline
//                       : TextDecoration.none,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

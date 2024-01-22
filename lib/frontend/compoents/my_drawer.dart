import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNavBar extends StatefulWidget {
  final Function(int) onItemSelected;
  // ignore: prefer_const_constructors_in_immutables
  MyNavBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  bool isOpen = true;

  Widget navItem(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, routeName);
        widget.onItemSelected(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40),
          if (isOpen)
            const SizedBox(
              width: 10,
            ),
          if (isOpen)
            Text(
              text,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width:
              isOpen ? 250 : 60, // Change the width based on the isOpen state
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.black],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              navItem(
                Icons.home_rounded,
                'Home',
                1,
              ), // Use the navItem function here
              const SizedBox(
                height: 25,
              ),
              navItem(
                Icons.settings_rounded,
                'Services',
                2,
              ), // Use the navItem function here
              const SizedBox(
                height: 25,
              ),
              navItem(
                Icons.contacts_rounded,
                'Contact Me',
                3,
              ), // Use the navItem function here
              const SizedBox(
                height: 25,
              ),
              navItem(
                Icons.verified_rounded,
                'Certfification',
                4,
              ),
              const SizedBox(
                height: 25,
              ),
              navItem(
                Icons.browse_gallery,
                'Project Gallery',
                5,
              ),
              const SizedBox(
                height: 25,
              ),
              navItem(
                Icons.description_rounded,
                'Resume',
                6,
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




//Orginal Code with any closing an opening

// class MyNavBar extends StatelessWidget {
//   const MyNavBar({Key? key}) : super(key: key);

//   Widget navItem(IconData icon, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 40),
//         const SizedBox(
//           width: 10,
//         ), // Add some spacing between the icon and the text
//         Text(
//           text,
//           style: GoogleFonts.playfairDisplay(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:
//           150, // Increase the width to accommodate the text next to the icons
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.white, Colors.orange.shade900],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           navItem(Icons.home, 'Home'), // Use the navItem function here
//           navItem(Icons.search, 'Search'), // Use the navItem function here
//           navItem(Icons.settings, 'Settings'), // Use the navItem function here
//         ],
//       ),
//     );
//   }
// }

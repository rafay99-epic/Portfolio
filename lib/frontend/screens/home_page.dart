// import 'package:flutter/material.dart';

// import '../compoents/my_drawer.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           const MyNavBar(),
//           // This is the main content area
//           Expanded(
//             child: Container(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../compoents/my_drawer.dart';
import 'Resume_page.dart';
import 'certification_page.dart';
import 'contentMe_page.dart';
import 'projectsGallary_page.dart';
import 'service_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = [
    const HomePage(),
    const ServicesPage(),
    const ContactMePage(),
    const CertificationPage(),
    const ProjectGalleryPage(),
    const ResumePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MyNavBar(
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // This is the main content area
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}

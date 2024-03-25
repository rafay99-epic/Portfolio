// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';

// import 'package:rafay_portfolio/user/frontend/views/ProjectGallery.dart';
import 'package:rafay_portfolio/user/frontend/pages/blogs/widgets/blog_builder.dart';
import 'package:rafay_portfolio/user/frontend/pages/blogs/widgets/floating_button.dart';
import 'package:rafay_portfolio/user/frontend/pages/blogs/widgets/no_internet.dart';

import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';
import 'dart:io' show Platform;

class DisplayBlog extends StatefulWidget {
  const DisplayBlog({super.key});

  @override
  _DisplayBlogState createState() => _DisplayBlogState();
}

class _DisplayBlogState extends State<DisplayBlog> {
  // ----------------------------
  // Controller and Varaiables
  // ----------------------------
  late ScrollController _scrollController;
  bool isSearchBarVisible = false;
  String searchQuery = '';
  bool _isInternetConnected = true;

  // ----------------------------
  // Init State & Dispose State
  // ----------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _checkInternetConnectivity();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ----------------------------
  // Scroll Down & Up Function
  // ----------------------------
  void _smoothScrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  // ----------------------------
  // Main Build Widget
  // ----------------------------
  @override
  Widget build(BuildContext context) {
    // ----------------------------
    // Screen Sizes
    // ----------------------------
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    // --------------------------------
    // Internet Net Check for Mobile
    // --------------------------------
    if (!_isInternetConnected) {
      return noInternetConnection(context);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // ---------------------------------------
      // App Bar, Only For Android Application
      // --------------------------------------
      appBar: !kIsWeb ? buildAppBar(context) : null,
      // ----------------------------
      // Main widget Body
      // ----------------------------
      body: buildBody(context, screenType),
      // --------------------------------
      // Floating Buttons for Web Only
      // -------------------------------
      floatingActionButton: MediaQuery.of(context).size.width > 600
          ? buildFloatingButton(context, _smoothScrollToTop, _smoothScrollDown)
          : null,
    );
  }

  // -------------------------------------------------------------
  // Checking Internet on Android Application & IOS Application
  // -------------------------------------------------------------
  Future<void> _checkInternetConnectivity() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _isInternetConnected = false;
        });
      }
    }
  }

  // ---------------------------------
  // Search Bar for Web Only devices
  // ---------------------------------
  Padding buildSearchBar(BuildContext context, ScreenType screenType) {
    return Padding(
      padding: (MediaQuery.of(context).size.width <= 600)
          ? const EdgeInsets.only(bottom: 30, left: 5.0)
          : const EdgeInsets.only(top: 25, bottom: 30),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedTextBuilder(
              text: "Articles",
              size: screenType.isMobile ? 40.0 : 72.0,
              underline: true,
            ),
          ),
          const Spacer(),
          if (MediaQuery.of(context).size.width > 600)
            AnimatedContainer(
              width: isSearchBarVisible ? 200 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSearchBarVisible
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Articles...',
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          if (MediaQuery.of(context).size.width > 600)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchBarVisible = !isSearchBarVisible;
                });
              },
            ),
        ],
      ),
    );
  }

  // ----------------------------------
  // App Bar for Android Application
  // ----------------------------------
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: isSearchBarVisible
          ? TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Articles...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            )
          : const Text(''),
      actions: [
        IconButton(
          icon: Icon(isSearchBarVisible ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              isSearchBarVisible = !isSearchBarVisible;
            });
          },
        ),
      ],
    );
  }

  // ----------------------------
  // Container for Main Body
  // ----------------------------
  Container buildBody(BuildContext context, ScreenType screenType) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          buildSearchBar(context, screenType),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: (searchQuery != '')
                    ? FirebaseFirestore.instance
                        .collection('blogPosts')
                        .where('isEnabled', isEqualTo: true)
                        .orderBy('title')
                        .startAt([searchQuery]).endAt(
                            ['$searchQuery\uf8ff']).snapshots()
                    : FirebaseFirestore.instance
                        .collection('blogPosts')
                        .where('isEnabled', isEqualTo: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SingleChildScrollView(
                      child: Center(
                        child:
                            Lottie.asset('assets/animation/datanotfound.json'),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Lottie.asset('assets/animation/loader.json'),
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    // Add this condition
                    return SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Lottie.asset(
                                  'assets/animation/datanotfound.json'),
                              const SizedBox(height: 10),
                              StyledText(
                                text: "Sorry!! No search results found. ",
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary,
                                textAlign: TextAlign.center,
                                bold: true,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // ----------------------------------------------
                  // Building Boxes and Display Blogs
                  //  - Passing all the data to another Widget
                  //  - Return and redndering the Widget
                  // ----------------------------------------------
                  return BlogLayoutBuilder(
                    snapshot: snapshot,
                    screenType: screenType,
                    setState: setState,
                    searchQuery: searchQuery,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/scrollAnimation/button_scroll.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/error.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/loading.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/widgets/blog_builder/blog_builder.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/floating_button.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/widgets/check_internet.dart/no_internet.dart';
import 'package:rafay_portfolio/constants/widgets/text/animatedtext.dart';
import 'dart:io' show Platform;

class DisplayBlog extends StatefulWidget {
  const DisplayBlog({super.key});

  @override
  _DisplayBlogState createState() => _DisplayBlogState();
}

class _DisplayBlogState extends State<DisplayBlog> with ScrollControllerMixin {
  // ----------------------------
  //  Varaiables
  // ----------------------------
  bool isSearchBarVisible = false;
  String searchQuery = '';
  bool _isInternetConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // ----------------------------
  // Main Build Widget
  // ----------------------------
  @override
  Widget build(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    if (!_isInternetConnected) {
      return noInternetConnection(context);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: !kIsWeb ? buildAppBar(context) : null,
      body: buildBody(context, screenType),
      floatingActionButton: screenType.isMobile
          ? null
          : buildFloatingButton(context, smoothScrollToTop, smoothScrollDown),
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
                    return buildErrorWidget(context);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingData();
                  }
                  snapshot.data!.docs.where((doc) {
                    final title = doc['title'] as String;
                    return title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();
                  if (snapshot.data!.docs.isEmpty) {
                    return buildErrorWidget(context);
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

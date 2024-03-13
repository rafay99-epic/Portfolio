// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/admin/backend/blog/blogSearch.dart';
import 'package:rafay_portfolio/user/frontend/widgets/HoverChip.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class DisplayBlog extends StatefulWidget {
  const DisplayBlog({super.key});

  @override
  _DisplayBlogState createState() => _DisplayBlogState();
}

class _DisplayBlogState extends State<DisplayBlog> {
  late ScrollController _scrollController;
  bool isSearchBarVisible = false;
  final BlogService blogService = BlogService();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll Down
  void _smoothScrollDown() {
    _scrollController.animateTo(
      _scrollController.offset +
          300, // Change this value to control how much you want to scroll down
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  //Scroll Top
  void _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 30, left: 30),
              child: Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedTextBuilder(
                      text: "Articles",
                      size: 55.0,
                      underline: true,
                    ),
                  ),
                  const Spacer(),
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
                                  blogService.searchQuery = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search Articles...',
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
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
            ),
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('blogPosts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child:
                            Lottie.asset('assets/animation/datanotfound.json'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Lottie.asset('assets/animation/loader.json'),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      // Add this condition
                      return Center(
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
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1 / 1,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle your blog post tap here
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            color: Theme.of(context).colorScheme.background,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      doc['thumbnail'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Text(
                                            'Error loading image');
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Title: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "roboto",
                                              ),
                                            ),
                                            TextSpan(
                                              text: doc['title'],
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontFamily: "roboto",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Author: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "roboto",
                                              ),
                                            ),
                                            TextSpan(
                                              text: doc['author'],
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontFamily: "roboto",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: List<Widget>.generate(
                                          doc['tags'].length,
                                          (int index) {
                                            return HoverChip(
                                                label: doc['tags'][index]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            focusColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.background,
            onPressed: _smoothScrollToTop,
            heroTag: "btn1",
            enableFeedback: true,
            child: const Icon(
              FontAwesomeIcons.arrowUp,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            focusColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.background,
            onPressed: _smoothScrollDown,
            enableFeedback: true,
            heroTag: "btn2",
            child: const Icon(
              FontAwesomeIcons.arrowDown,
            ),
          ),
        ],
      ),
    );
  }
}
